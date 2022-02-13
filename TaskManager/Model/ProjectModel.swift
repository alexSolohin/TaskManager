//
//  ProjectModel.swift
//  TaskManager
//
//  Created by Aleksandr Baskin on 06.01.2022.
//

import Foundation
import SwiftUI
import CoreData

public class Task: NSObject, Codable {
    var id = UUID()
    var name: String = ""
    var done : Bool
    
    init?(name: String, done: Bool) {
        self.name = name
        self.done = done
        super.init()
    }
}

struct ProjectViewModel {
    let project: ProjectData
    
    var id: NSManagedObjectID {
        return project.objectID
    }
    
    var projectName: String {
        return project.projectName ?? ""
    }
}

class ProjectModel: ObservableObject {
    @Published var projects: [ProjectViewModel] = []
    var text = ""
    
    func getAllProjects() {
        projects = AplicationData.shared.GetAllProjects().map(ProjectViewModel.init)
    }
    
    func save() {
        let projectData = ProjectData(context: AplicationData.shared.viewContext)
        projectData.projectName = text
        
        AplicationData.shared.save()
    }
    
    func delete(project: ProjectViewModel) {
        let project = AplicationData.shared.getTaskByID(id: project.id)
        if let project = project {
            AplicationData.shared.deleteProject(project: project)
        }
    }
    
}

