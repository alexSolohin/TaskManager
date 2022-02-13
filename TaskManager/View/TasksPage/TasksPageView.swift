//
//  TaskView.swift
//  TaskManager
//
//  Created by user on 05.12.2021.
//

import SwiftUI

struct TasksPageView: View {
    @EnvironmentObject var projectModel: ProjectModel
    @State var selectedView : Int = 0
    @State var showOption = false
    
    func deleteProject(at offsets: IndexSet) {
        offsets.forEach { index in
            let project = projectModel.projects[index]
            projectModel.delete(project: project)
        }
        
        projectModel.getAllProjects()
    }
    
    var body: some View {
        VStack{
            HStack {
                TextField("Enter task name", text: $projectModel.text).textFieldStyle(.roundedBorder)
                Button("Save") {
                    projectModel.save()
                    projectModel.getAllProjects()
                }.buttonStyle(.bordered)
            }.padding()
            
            List {
                ForEach(projectModel.projects,  id: \.id) { project in
                    Text(project.projectName)
                }.onDelete(perform: deleteProject)
            }
            TasksListSection(selectedView: $selectedView)
            Spacer()
            VStack {
                TabView(selection: $selectedView) {
                    ForEach(Array(projectModel.projects.enumerated()), id: \.offset) { index, project in
                        ProjectView(nameProject: project.projectName).tag(index)
                    }
                    NewProjectView().tag(projectModel.projects.count).onTapGesture {
                        showOption = true
                    }
                }.tabViewStyle(.page(indexDisplayMode: .never))
            }.frame(width: UIScreen.main.bounds.width, height: 60).background(.white)
         }.sheet(isPresented: $showOption) {
//
        }
    }
}

struct TasksListSection: View {
    @EnvironmentObject var projectModel: ProjectModel
    @Binding var selectedView: Int
    @State var isTap = false
    
    var drag : some Gesture {
        DragGesture()
        .onChanged{_ in self.isTap = true}
        .onEnded{_ in self.isTap = false}
    }
    
    var body: some View {
        TabView(selection: $selectedView) {
            ForEach(Array(projectModel.projects.enumerated()), id: \.offset) { index, project in
                Text(project.projectName)
//                TaskListView(tasks: project.nameTasks ?? []).tag(index)
            }
            NewProjectOptionsView().tag(projectModel.projects.count)
        }
    }
}

struct TasksPageView_Previews: PreviewProvider {
    static var previews: some View {
        TasksPageView(selectedView: 1)
    }
}
