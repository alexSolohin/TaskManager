//
//  TaskView.swift
//  TaskManager
//
//  Created by user on 05.12.2021.
//

import SwiftUI

struct TasksPageView: View {
    @StateObject var projects = ProjectModel()
    @State var selectedView = 0
    @State var showOption = false
    
    var body: some View {
        VStack{
            TasksListSection(selectedView: $selectedView).environmentObject(projects)
            Spacer()
            VStack {
                TabView(selection: $selectedView) {
                    ForEach(Array(projects.projects.enumerated()), id: \.offset) { index, project in
                        ProjectView(nameProject: project.nameGoal).tag(index)
                    }
                    NewProjectView().tag(projects.projects.count).onTapGesture {
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
    @EnvironmentObject var projects: ProjectModel
    @Binding var selectedView: Int
    @State var isTap = false
    
    var drag : some Gesture {
        DragGesture()
        .onChanged{_ in self.isTap = true}
        .onEnded{_ in self.isTap = false}
    }
    
    var body: some View {
        TabView(selection: $selectedView) {
            ForEach(Array(projects.projects.enumerated()), id: \.offset) { index, project in
                TaskListView(tasks: project.nameTasks).tag(index)
            }
            NewProjectOptionsView().tag(projects.projects.count).environmentObject(projects)
        }
    }
}

struct TasksPageView_Previews: PreviewProvider {
    static var previews: some View {
        TasksPageView()
    }
}
