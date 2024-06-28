//
//  ViewController.swift
//  FileManagementOne
//
//  Created by Ankith on 26/06/24.
//

import UIKit

class ViewController: UIViewController {

    var customDirectory:URL!
    
    init() {

        super.init(nibName: nil, bundle: nil)
        
        let filemanager = FileManager.default
        let documentDirectory = filemanager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let customDir = documentDirectory.appendingPathComponent("CustomDirectory", conformingTo: .directory)
        
        do{
            if !filemanager.fileExists(atPath: customDir.path()){
                try filemanager.createDirectory(at: customDir, withIntermediateDirectories: true)
            }
        }catch{
            debugPrint("Error: \(error.localizedDescription)")
        }
        
        self.customDirectory = customDir
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        
        createSampleFiles()
        
    }
    
    
    func createSampleFiles(){
        let filemanager = FileManager.default
        do{
            for _ in 0..<5{
                createFile(customDirectory)
            }
            
            //list contents
            let files = try filemanager.contentsOfDirectory(at: customDirectory, includingPropertiesForKeys: nil)
            
            debugPrint("Files in directory")
            for filename in files{
                debugPrint(filename.lastPathComponent)
            }
        }catch{
            debugPrint("Error: \(error.localizedDescription)")
        }
    }

    fileprivate func createFile(_ customDirectory: URL) {
        let filemanager = FileManager.default
        //create a file in custom directory
        let id = UUID().uuidString
        let simpleTextFile = customDirectory.appending(path: "logFile_\(id).txt")
        let result = filemanager.createFile(atPath: simpleTextFile.path(), contents: "hi this is a test file, created at \(Date.now) with id: \(id)".data(using: .utf8))
        debugPrint("file created:\(result), log_fileName: \(simpleTextFile.lastPathComponent)")
    }
    
}

