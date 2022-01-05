//
//  ProjectView.swift
//  TaskManager
//
//  Created by Aleksandr Baskin on 12.12.2021.
//

import SwiftUI

struct ProjectView: View {
    var nameProject: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(Color("BarBackgroundColor")).frame(width: UIScreen.main.bounds.width - 30, height: 50)
                .shadow(color: .gray, radius: 5, x: 0, y: 2)
            Text(nameProject).foregroundColor(.white)
        }.frame(width: UIScreen.main.bounds.width, height: 50)
        
    }
}

struct NewProjectView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(Color("BarBackgroundColor")).frame(width: UIScreen.main.bounds.width - 30, height: 50)
                .shadow(color: .gray, radius: 5, x: 0, y: 2)
            Image(systemName: "plus").foregroundColor(.white)
        }.frame(width: UIScreen.main.bounds.width, height: 50)
        
    }
}


struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView(nameProject: "First Project")
        NewProjectView()
    }
}
