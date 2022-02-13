//
//  NewProjectOptionsView.swift
//  TaskManager
//
//  Created by Aleksandr Baskin on 11.01.2022.
//

import SwiftUI

struct NewProjectOptionsView: View {

    @State var name = "New project ";
    
    var body: some View {
        VStack {
            Section {
                TextField("Name", text: $name).padding()
            }
            Spacer()
            Button("Create", action: {
            }).buttonStyle(.bordered)
        }
    }
    
//    func create()
//    {
//        let project = ProjectData(nameGoal: name, nameTasks: [], isTaskCompleted: [])
//        projects.AddNewProject(project: project)
//    }
}

//struct NewProjectOptionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewProjectOptionsView()
//    }
//}
