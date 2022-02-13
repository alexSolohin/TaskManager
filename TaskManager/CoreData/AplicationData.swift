//
//  AplicationData.swift
//  TaskManager
//
//  Created by Aleksandr Baskin on 16.01.2022.
//

import Foundation
import CoreData
import UIKit

class AplicationData: ObservableObject {
    let container = NSPersistentContainer(name: "TaskDataModel")
    
    static let shared = AplicationData()
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func getTaskByID(id: NSManagedObjectID) -> ProjectData? {
        do {
            return try viewContext.existingObject(with: id) as? ProjectData
        } catch {
            return nil
        }
    }
    
    func GetAllProjects() -> [ProjectData] {
        let request: NSFetchRequest<ProjectData> = ProjectData.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func deleteProject(project: ProjectData) {
        viewContext.delete(project)
        save()
    }
    
    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
