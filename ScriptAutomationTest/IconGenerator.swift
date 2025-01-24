import Foundation

class IconGenerator {
    func generateAppIcon() {
        let svgContent = """
        <?xml version="1.0" encoding="UTF-8"?>
        <svg width="1024" height="1024" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg">
            <!-- Gradient Background -->
            <defs>
                <linearGradient id="bgGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                    <stop offset="0%" style="stop-color:#FF9500"/>
                    <stop offset="100%" style="stop-color:#007AFF"/>
                </linearGradient>
                <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
                    <feGaussianBlur in="SourceAlpha" stdDeviation="10"/>
                    <feOffset dx="0" dy="10" result="offsetblur"/>
                    <feFlood flood-color="#00000044"/>
                    <feComposite in2="offsetblur" operator="in"/>
                    <feMerge>
                        <feMergeNode/>
                        <feMergeNode in="SourceGraphic"/>
                    </feMerge>
                </filter>
            </defs>
            
            <!-- Rounded Rectangle Background -->
            <rect x="0" y="0" width="1024" height="1024" rx="200" ry="200" fill="url(#bgGradient)"/>
            
            <!-- Main Swift Bird -->
            <g transform="translate(200, 45) scale(20)" filter="url(#shadow)">
                <path d="M22.1356 25.2715C18.835 27.17 14.2967 27.3651 9.73079 25.4166C6.03387 23.8505 2.96639 21.109 1 17.9767C1.94387 18.7598 3.04503 19.3865 4.22484 19.9344C8.9401 22.135 13.6544 21.9843 16.972 19.94C12.2526 16.3374 8.23626 11.6326 5.2475 7.79547C4.61799 7.16887 4.14605 6.38567 3.67412 5.68084C7.29225 8.97014 13.0343 13.1207 15.0789 14.296C10.7535 9.75321 6.8991 4.1147 7.0561 4.27103C13.8993 11.163 20.2707 15.079 20.2707 15.079C20.4815 15.1974 20.6442 15.2959 20.775 15.384C20.9129 15.0347 21.0338 14.672 21.1357 14.296C22.2368 10.3018 20.9787 5.759 18.2254 2C24.5962 5.83752 28.3721 13.0425 26.7985 19.0732C26.7575 19.2359 26.7129 19.3965 26.6648 19.5542C29.8106 23.4703 29.0008 27.6884 28.6076 26.9053C26.901 23.5801 23.7418 24.5969 22.1356 25.2715Z" 
                      fill="white"/>
            </g>
            
            <!-- Apple Logo -->
            <g transform="translate(190, 650) scale(0.25)" filter="url(#shadow)">
                <path d="M788.1 340.9c-5.8 4.5-108.2 62.2-108.2 190.5 0 148.4 130.3 200.9 134.2 202.2-.6 3.2-20.7 71.9-68.7 141.9-42.8 61.6-87.5 123.1-155.5 123.1s-85.5-39.5-164-39.5c-76.5 0-103.7 40.8-165.9 40.8s-105.6-57-155.5-127C46.7 790.7 0 663 0 541.8c0-194.4 126.4-297.5 250.8-297.5 66.1 0 121.2 43.4 162.7 43.4 39.5 0 101.1-46 176.3-46 28.5 0 130.9 2.6 198.3 99.2zm-234-181.5c31.1-36.9 53.1-88.1 53.1-139.3 0-7.1-.6-14.3-1.9-20.1-50.6 1.9-110.8 33.7-147.1 75.8-28.5 32.4-55.1 83.6-55.1 135.5 0 7.8 1.3 15.6 1.9 18.1 3.2.6 8.4 1.3 13.6 1.3 45.4 0 102.5-30.4 135.5-71.3z"
                      fill="white"/>
            </g>
            
            <!-- Swift Text -->
            <g transform="translate(420, 600) scale(0.85)" filter="url(#shadow)">
                <path d="M159.29,238.65c3.93-5.76,10.48-16.24,7.86-27-1.84-7.07-6.55-15.72-13.89-22.54-4.46-3.67-9.7-5.51-15.98-5.51s-11.54.79-20.19,4.46c-23.58,9.96-64.47,41.15-64.47,76.8,0,26.73,36.43,40.88,55.31,55.56,2.88,2.36,4.19,7.07.26,11.01-2.88,2.88-8.12,4.18-13.89,4.18-15.2,0-32.49-13.1-42.71-21.49-5.51-4.45-12.85-6.55-20.45-6.55-3.15,0-6.03.27-8.13.79-3.66,1.31-5.5,4.19-1.82,8.65,20.7,23.85,46.12,34.59,65.26,34.59,15.72,0,28.57-5.51,35.38-13.37,6.81-8.12,10.21-14.94,10.21-20.97,0-4.98-2.88-9.7-7.85-13.37-10.22-7.33-46.13-22.27-45.35-39.57,1.31-30.14,58.71-68.68,68.41-61.6,3.67,2.62-3.4,14.16-9.96,23.85-8.65,11.54-12.06,21.5-12.06,27.26s2.61,10.49,6.29,14.15c4.98,5.25,7.86,3.15,10.22-1.05,3.67-6.29,11.27-19.92,17.56-28.31Z M366.76,246.51c6.55,0,10.49-6.03,10.49-13.1,0-7.6-7.07-17.03-14.42-17.03-6.03,0-11.54,6.81-11.54,14.15,0,8.12,7.07,15.98,15.46,15.98Z M542.18,236.29c-1.84-3.14-6.29-7.33-14.42-8.39,3.15-7.33,4.19-13.36,4.19-18.09,0-3.14-1.05-7.6-2.88-10.75-2.88-4.97-6.03-5.24-9.96.53-6.03,8.64-11.54,17.3-19.67,31.45-5.76.52-12.84.79-18.87.52-6.03-.26-8.65,2.36-4.98,7.86,2.1,3.15,6.82,6.03,14.94,7.07-10.48,18.88-20.45,39.58-25.68,52.43-1.53,3.6-2.68,6.97-3.51,10.1-8.04,14.24-22.15,29.26-40.04,32.88,8.39-6.82,17.03-18.61,23.33-33.03,6.03-12.58,10.22-25.95,10.22-37.22,0-13.36-7.6-27.52-23.33-27.52-7.07,0-14.68,3.41-21.23,7.86,0-3.4-.52-6.82-2.61-9.7-2.1-2.88-5.51-3.93-10.22,1.84-10.13,13.56-30.75,50.35-46.69,82.16-6.27,7.84-13.05,13.24-18.86,13.24-2.88,0-3.93-2.36-3.93-6.55s1.31-9.7,3.67-15.73c4.45-10.48,16.51-30.14,21.49-41.41,6.82-13.1,4.72-24.37-.27-29.61-3.4-3.94-6.55-3.41-10.48,1.84-9.7,13.63-26.47,44.03-33.03,62.37-.02.06-.03.12-.05.17-8.22,16.1-21.3,29.9-29.4,29.19-3.93-.27-6.03-4.2-6.03-10.76,0-3.93.79-7.85,2.1-11.79,4.19-13.89,17.03-30.92,28.3-44.03,3.15-3.41,4.46-7.34,4.46-10.49,0-6.81-3.15-13.1-7.34-17.82-3.4-3.67-7.6-2.62-11.52.26-8.39,6.03-15.47,9.44-22.8,11.28,2.88-8.65,4.97-16.52,4.97-22.02s-2.09-9.17-7.6-9.17c-8.91.26-26.21,19.39-26.21,33.28,0,4.98,1.84,8.91,7.33,11.54-13.63,32.24-41.67,70.5-67.35,69.46-7.6-.52-12.06-7.86-12.06-18.88,0-7.85,2.62-18.34,7.86-29.09,11.01-22.28,27.79-38.27,31.19-35.64,1.31,1.05-1.31,6.29-3.94,11.79-2.61,6.03-6.03,14.67-6.03,18.61,0,7.07,3.94,12.58,9.18,15.2,6.55,3.41,7.6,2.1,9.43-3.4.79-2.88,2.89-6.82,4.73-10.75,4.97-10.22,9.17-19.66,5.24-28.04-2.88-5.51-7.6-10.22-15.46-14.94-2.62-1.58-5.77-2.1-9.18-2.1-15.21,0-35.91,14.68-49.8,41.41-5.24,10.49-7.86,20.97-7.86,30.14,0,20.45,13.1,36.16,37.22,36.16,33.28,0,62.65-35.64,81.51-77.58,6.03-.27,13.37-1.84,20.45-4.72-14.42,17.03-28.31,41.94-28.31,55.56,0,15.46,9.18,27,25.95,27,9.46,0,20.99-4.59,29.75-12.19,3.04,7.33,9.87,11.93,21.19,11.93,3.53,0,7.19-.58,10.83-1.66-4.57,9.95-8.06,18.36-9.77,23.94-2.36,7.34-3.15,12.85-3.15,17.04,0,5.51,1.31,9.18,5.24,14.15,2.62,3.15,5.77,2.1,7.86-2.61,11.01-25.7,22.28-48.23,33.82-69.72,6.03,14.15,18.87,21.22,39.58,21.22,17.9,0,35.97-4.97,48.39-18.57,4.22,10.23,13.36,16.21,23.48,16.21,22.01,0,39.58-22.54,43.24-30.4,2.89-6.03,3.94-9.96,2.62-15.46-1.84-7.07-7.86-6.55-10.75-.27-9.18,19.67-22.8,36.17-33.03,36.17-4.45,0-7.07-5.51-7.07-13.37,0-5.76,1.57-12.58,4.72-19.66,9.18-19.92,24.12-45.86,34.07-62.9,5.77-.79,12.58-1.31,17.3-.79,6.3.79,8.13-2.36,5.51-7.07Z M392.47,334.32c-6.82,0-8.65-18.88-.52-35.65l8.39-14.15c11.27-19.13,25.68-31.19,30.4-29.1,1.31.53,1.84,3.67,1.84,8.39,0,8.65-3.15,22.02-9.43,34.34-10.75,21.76-22.55,36.17-30.67,36.17Z"
                      fill="white"/>
            </g>
            
            <!-- Script Text -->
            <text x="512" y="900" 
                  font-family="Brush Script MT" 
                  font-size="120" 
                  text-anchor="middle" 
                  fill="white" 
                  filter="url(#shadow)">
                Script
            </text>
        </svg>
        """
        
        if let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let svgURL = desktopURL.appendingPathComponent("icon.svg")
            let pngURL = desktopURL.appendingPathComponent("icon.png")
            
            do {
                try svgContent.write(to: svgURL, atomically: true, encoding: .utf8)
                
                // Convert to PNG using sips
                let process = Process()
                process.executableURL = URL(fileURLWithPath: "/usr/bin/sips")
                process.arguments = ["-s", "format", "png", svgURL.path, "--out", pngURL.path]
                
                try process.run()
                process.waitUntilExit()
                
                // Clean up SVG
                try FileManager.default.removeItem(at: svgURL)
                
                // Update project assets
                try updateProjectAssets(with: pngURL)
                
                print("Icon generated and project updated successfully")
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    private func updateProjectAssets(with iconURL: URL) throws {
        let fileManager = FileManager.default
        
        // Create SwiftScript folder on desktop
        guard let desktopURL = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first else {
            throw NSError(domain: "IconGenerator", code: 1, userInfo: [NSLocalizedDescriptionKey: "Could not access desktop"])
        }
        
        let swiftScriptURL = desktopURL.appendingPathComponent("SwiftScript")
        let appIconURL = swiftScriptURL.appendingPathComponent("AppIcon.appiconset")
        
        // Create directories
        try fileManager.createDirectory(at: appIconURL, withIntermediateDirectories: true)
        
        // Generate different icon sizes
        let iconSizes = [
            (16, 1), (16, 2),
            (32, 1), (32, 2),
            (128, 1), (128, 2),
            (256, 1), (256, 2),
            (512, 1), (512, 2),
        ]
        
        // Contents.json structure
        let contents: [String: Any] = [
            "images": iconSizes.map { size, scale in [
                "size": "\(size)x\(size)",
                "idiom": "mac",
                "filename": "icon_\(size)x\(size)@\(scale)x.png",
                "scale": "\(scale)x"
            ]},
            "info": [
                "version": 1,
                "author": "xcode"
            ]
        ]
        
        // Generate and save each icon size
        for (size, scale) in iconSizes {
            let finalSize = size * scale
            let outputURL = appIconURL.appendingPathComponent("icon_\(size)x\(size)@\(scale)x.png")
            
            let process = Process()
            process.executableURL = URL(fileURLWithPath: "/usr/bin/sips")
            process.arguments = [
                "-z", "\(finalSize)", "\(finalSize)",
                iconURL.path,
                "--out", outputURL.path
            ]
            
            try process.run()
            process.waitUntilExit()
        }
        
        // Save Contents.json
        let jsonData = try JSONSerialization.data(withJSONObject: contents, options: .prettyPrinted)
        try jsonData.write(to: appIconURL.appendingPathComponent("Contents.json"))
        
        print("Files generated in: \(swiftScriptURL.path)")
    }
} 
