//
//  ContentView.swift
//  toDoListApp
//
//  Created by Scholar on 7/14/23.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(
        entity: ToDo.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \ToDo.id, ascending: false) ])
    
    var toDoItems: FetchedResults<ToDo>
    @Environment(\.managedObjectContext) var context
    @State private var showNewTask = false
    var body: some View {
        VStack {
            HStack{
                Text("To Do List")
                    .font(.system(size: 40))
                    .fontWeight(.black)
                Spacer()
                Button(action: {
                    self.showNewTask = true
                }) {
                    Text("+")
                    
                }
            }.padding()
            Spacer()
        }
        .padding()
        
        List {
            ForEach (toDoItems) { toDoItem in
                if toDoItem.isImportant == true {
                    Text("‼️" + (toDoItem.title ?? "No title"))
                } else {
                    Text(toDoItem.title ?? "No title")
                }
            }.onDelete(perform: deleteTask)
        }.listStyle(.plain)
        
        if showNewTask {
            NewToDoView(title: "", isImportant: false,showNewTask: $showNewTask)
        }
    }
    private func deleteTask(offsets: IndexSet) {
            withAnimation {
                offsets.map { toDoItems[$0] }.forEach(context.delete)

                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
