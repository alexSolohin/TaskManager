//
//  AplicationData.swift
//  TaskManager
//
//  Created by Aleksandr Baskin on 16.01.2022.
//

import Foundation
import CoreData

class AplicationData: ObservableObject {
    let container = NSPersistentContainer(name: "TaskDataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed load")
            }
        }
    }
}
