import Foundation
import ScriptingBridge

class XcodeBuildScript {
    func buildCurrentWorkspace(projectPath: String) -> String {
        // Get Xcode application instance
        guard let xcode: XcodeApplication = SBApplication(bundleIdentifier: "com.apple.dt.Xcode") else {
            return "Failed to connect to Xcode"
        }
        
        // Open the project
        let xcDoc = xcode.open?(projectPath as Any)
        
        // Run the document
        guard
            let currentWorkspace = xcDoc as? XcodeWorkspaceDocument else {
            return "No workspace document found"
        }
        
        guard let buildResult = currentWorkspace.runWithCommandLineArguments?(nil, withEnvironmentVariables: nil) else {
                  return "Failed to start build"
              }
      
            
        // Wait for build to complete
        while !(buildResult.completed ?? false) {
            Thread.sleep(forTimeInterval: 0.5)
        }
        
        var buildResults = ""
        
        // Check build errors
        if let buildErrors = buildResult.buildErrors?() {
            for case let error as XcodeBuildError in buildErrors {
                if let errorMessage = error.message {
                    if let filePath = error.filePath {
                        let lineNum = error.startingLineNumber ?? 0
                        buildResults += "Error: \(errorMessage) in \(filePath) (line \(lineNum))\n"
                    } else {
                        buildResults += "Error: \(errorMessage)\n"
                    }
                }
            }
        }
        
        return buildResults.isEmpty ? "🐦📜 Ran successfully" : buildResults
    }
}
