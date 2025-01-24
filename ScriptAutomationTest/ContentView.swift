import SwiftUI
import ScriptingBridge
import Foundation
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var projectPath: String = ""
    @State private var output: String = ""
    @State private var isValidPath: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("🐦🍎📜 Automation Test App")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Button("Choose Project") {
                    let panel = NSOpenPanel()
                    panel.allowsMultipleSelection = false
                    panel.canChooseDirectories = false
                    panel.canChooseFiles = true
                    panel.allowedFileTypes = ["xcodeproj", "xcworkspace"]
                    
                    if panel.runModal() == .OK {
                        projectPath = panel.url?.path ?? ""
                        validatePath()
                    }
                }
                
                TextField("Xcode Project Path", text: $projectPath)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .firstTextBaseline) {
                
                
                Button("Run OsaScript (also triggers perms)") {
                    output = executeWithOsascript(script: OsaScriptBuildAndRun(projectPath: projectPath))
                }
                .disabled(!isValidPath)
                
                Button("Run AppleScript") {
                    if isValidPath {
                        output = executeAppleScript(script: AppleScriptBuildAndRun(projectPath: projectPath))
                    } else {
                        output = "Please select a valid Xcode project path"
                    }
                }
                .disabled(!isValidPath)
                
                Button("Run Swift ScriptingBridge") {
                    if isValidPath {
                        output = XcodeBuildScript().buildCurrentWorkspace(projectPath: projectPath)
                    } else {
                        output = "Please select a valid Xcode project path"
                    }
                }
                .disabled(!isValidPath)
                
                 Spacer()
            }
            
            Button("Make Asset Catalog for Icon on Desktop") {
                IconGenerator().generateAppIcon()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Output:")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView {
                Text(output)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
    }
    
    func executeAppleScript(script: String) -> String {
        if let appleScript = NSAppleScript(source: script) {
            var errorDict: NSDictionary? = nil
            let output = appleScript.executeAndReturnError(&errorDict)
            
            if let error = errorDict {
                return "Error: \(error)"
            }
            return output.stringValue ?? "AppleScript executed successfully."
        } else {
            return "Failed to create AppleScript."
        }
    }
    
    func executeWithOsascript(script: String) -> String {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/osascript")
        
        // Create a pipe to capture the output
        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        process.arguments = ["-e", script]
        
        do {
            try process.run()
            
            // Wait for the process to finish
            process.waitUntilExit()
            
            // Read the output data
            let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
            
            // Convert the data to a string
            if let result = String(data: data, encoding: .utf8) {
                print(result)
                print("AppleScript executed via osascript.")
                return result.trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                print("Failed to convert output data to string.")
                return ""
            }
        } catch {
            print("Failed to execute osascript: \(error)")
            return ""
        }
    }
    
    private func validatePath() {
        let fileManager = FileManager.default
        isValidPath = fileManager.fileExists(atPath: projectPath) && 
                     (projectPath.hasSuffix(".xcodeproj") || projectPath.hasSuffix(".xcworkspace"))
    }
}
