//
//  TaskListView.swift
//  TaskManager
//
//  Created by Aleksandr Baskin on 18.12.2021.
//

import SwiftUI

struct TaskData: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var complete = false
}

struct TaskListView: View {
   
    @State private var select = Set<UUID>()
    
    @State var tasks = [TaskData(name: "First task"),
                        TaskData(name: "Second task"),
                        TaskData(name: "Third task"),
                        TaskData(name: "Four task")]
        
    var body: some View {
        List(tasks, selection: $select) {task in
            TaskView(task: task, select: $select, tasks: $tasks)
        }.listStyle(PlainListStyle()).animation(.easeInOut)
    }
    
    func delete(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func move(at offsets: IndexSet, to dest: Int)
    {
        tasks.move(fromOffsets: offsets, toOffset: dest)
    }
    
}

struct TaskView: View {
    var task: TaskData
    @State var color = Color.gray
    @Binding var select: Set<UUID>
    @Binding var tasks: [TaskData]
    
    var body: some View {
        TaskRect(name: task.name).listRowBackground(color).swipeActions(edge: .leading, content:{
            Button{ complete() } label: {
                Label("Complete", systemImage: "heart.fill")
            }.tint(.green)
            }).swipeActions(edge: .trailing, content: {
                Button() { print("task") } label: {
                    Label("More", systemImage: "ellipsis.circle.fill")
                }.tint(.indigo)
                Button(role: .destructive) { tasks.remove(at: tasks.firstIndex(of: task)!)} label: {
                    Label("Delete", systemImage: "trash.fill")
                }.highPriorityGesture(DragGesture())
            })
    }
    
    func complete()
    {
        color = Color.green
        let index = tasks.firstIndex(of: task)
        if (index != nil) {
            let elem = tasks.remove(at: index!)
            tasks.insert(elem, at: tasks.count)
        }
    }
    

}

struct TaskRect: View {
    var name: String
    
    var body: some View {
            HStack {
                VStack{
                    Text(name)
                    Text("info").font(.subheadline)
                }
                Spacer()
                Image(systemName: "heart.fill")
            }.padding()
        }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
.previewInterfaceOrientation(.portrait)
    }
}
