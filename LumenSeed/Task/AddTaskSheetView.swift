//
//  AddTaskSheetView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/14/24.
//

import SwiftUI

struct AddTaskSheetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var estimatedPomodoros: Int
    @State private var taskTitle: String = ""
    @State private var taskDescription: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Project Name")
                TextField("Enter task title", text: $taskTitle)
                    .padding()
                    .font(.title3)
                    .cornerRadius(50.0)
                    .textFieldStyle(.plain)
                    .background(Color.gray.opacity(0.1))
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    .cornerRadius(8)
                    .accentColor(Color.lumenGreen)
                    .textFieldStyle(.roundedBorder)
                
                Text("Description")
                TextField("What are you working on?", text: $taskDescription)
                    .padding()
                    .font(.title3)
                    .cornerRadius(50.0)
                    .textFieldStyle(.plain)
                    .background(Color.gray.opacity(0.1))
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    .cornerRadius(8)
                    .accentColor(Color.lumenGreen)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    Text("Est Pomodoros")
                    Stepper(value: $estimatedPomodoros, in: 1...10) {
                        Text("\(estimatedPomodoros)")
                            .frame(minWidth: 36)
                    }
                }
                .padding(.all, 4)
                
                Spacer()
            }
            .navigationBarTitle("Task", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        let newTask = TaskEntity(context: viewContext)
                        newTask.id = UUID()
                        newTask.title = taskTitle
                        newTask.taskDescription = taskDescription
                        newTask.pomodoroCount = Int32(estimatedPomodoros)
                        newTask.pomodoroDoneCount = 0
                        newTask.isDone = false
                        saveContext()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundStyle(Color.lumenSecondary)
                }
            }
        }
        .padding()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
//#Preview {
//    AddTaskSheetView(estimatedPomodoros: .constant(2), tasks: .constant([Task(title: "tesla", description: "implement button", status: "pending", tags: [], pomodoroCount: 2, pomodoroDoneCount: 0, isDone: false)]))
//}
