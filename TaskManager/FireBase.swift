//
//  FireBase.swift
//  TaskManager
//
//  Created by user on 05.12.2021.
//

import Foundation
import Firebase

struct ProjectData: Codable {
    var nameGoal : String
    var nameTasks : [Task]
    var isTaskCompleted : [Bool]
}

struct Task: Codable {
    var name: String
    var id : Int
    var done : Bool
}

class FirebaseInitial {
    
    public var storageRef : StorageReference
    public var projectsData : StorageReference
    public var jsonString = ""
    
    //for test
    var projectsArr : [ProjectData]
    
    init() {
        FirebaseApp.configure()
        let storage = Storage.storage()
        self.storageRef = storage.reference()
        self.projectsData = storageRef.child("ProjectData/ProjectData.json")
        
        //for test
        let task = Task(name: "task", id: 0, done: false)
        let proj1 = ProjectData(nameGoal: "firstGoal", nameTasks: [task], isTaskCompleted: [false, false])
        let proj2 = ProjectData(nameGoal: "secondGoal", nameTasks: [task], isTaskCompleted: [false, false])
        projectsArr = [proj1, proj2]
    }
    
    public func CreateJson() {
        do {
            let jsonData = try JSONEncoder().encode(projectsArr)
            self.jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
        } catch { print("False") }
    }
    
    public func SaveJsonToFile()
    {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("ProjectData.json")
            do {
                try self.jsonString.write(to: pathWithFilename,
                                     atomically: true,
                                     encoding: .utf8)
                print("Done write to file to \(pathWithFilename)")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func localPath() -> URL?
    {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("ProjectData.json")
            return pathWithFilename
        }
        return nil
    }
    
    func DownLoadFileFromFB()
    {
        // Create a reference to the file you want to download
        let islandRef = storageRef.child("ProjectData/ProjectData.json")

        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
              print(error.localizedDescription)
          } else {
            // Data for "images/island.jpg" is returned
            let data = data
            let json = String(decoding: data!, as: UTF8.self)
            let jsonData = json.data(using: .utf8)
            let decoder = JSONDecoder()
            let projectArr: [ProjectData] = try! decoder.decode([ProjectData].self, from: jsonData!)
              print(projectArr[0].nameGoal)
          }
        }
    }
    
    func UploadFile()
    {
        let localFile = self.localPath()!
        let data = loadFileFromLocalPath(localFile)
        print(localFile)
        // Create a reference to the file you want to upload
        let projectDataRef = self.storageRef.child("ProjectData/ProjectData.json")

        print(projectDataRef)
        
        let uploadTask = projectDataRef.putData(data!, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
              print(error?.localizedDescription)
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          print("Upload done")
          // You can also access to download URL after upload.
          projectDataRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
          }        
        }
    }
    
    func LoadJsonFromFile() -> Data?
    {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("ProjectData.json")
            let data = self.loadFileFromLocalPath(pathWithFilename)
            return data
        }
        return nil
    }
    
    func loadFileFromLocalPath(_ localFilePath: URL) ->Data? {
        return try? Data(contentsOf: localFilePath)
    }
}
    
