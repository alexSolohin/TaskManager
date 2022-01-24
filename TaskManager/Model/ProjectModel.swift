//
//  ProjectModel.swift
//  TaskManager
//
//  Created by Aleksandr Baskin on 06.01.2022.
//

import Foundation
import SwiftUI

struct ProjectData: Codable, Identifiable {
    var id = UUID()
    var nameGoal : String
    var nameTasks : [Task]
    var isTaskCompleted : [Bool]
}

struct Task: Codable, Identifiable, Equatable {
    var id = UUID()
    var name: String
    var done : Bool
}

class ProjectModel: ObservableObject {
    @Published var projects = [ProjectData]()
    var firebase: FirebaseInitial = FirebaseInitial()
    
    //for test
    var testData1 = ProjectData(nameGoal: "first project", nameTasks: [Task(name: "First Task", done: false), Task(name: "Second Task", done: false)], isTaskCompleted: [])
    var testData2 = ProjectData(nameGoal: "second project", nameTasks: [Task(name: "Second Task", done: false), Task(name: "Second Task", done: false)], isTaskCompleted: [])
    var testData3 = ProjectData(nameGoal: "third project", nameTasks: [Task(name: "Third Task", done: false), Task(name: "Second Task", done: false)], isTaskCompleted: [])
    
    init() {
//        projects = self.firebase.DownLoadFileFromFB()
        
        //for test
        projects.append(testData1)
        projects.append(testData2)
        projects.append(testData3)
    }
    
    func AddNewProject(project: ProjectData) {
        self.projects.append(project)
    }
    
    func RemoveProject(project: ProjectData) {
        let index = self.projects.firstIndex{$0.id == project.id}
        if (index == nil) {
            return
        }
        self.projects.remove(at: index!)
    }
    
}

extension Task {
    var doneId: String {
        "done\(id)"
    }
    
    var NotDoneId: String {
        "Not done\(id)"
    }
}
