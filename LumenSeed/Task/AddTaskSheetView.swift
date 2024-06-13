//
//  AddTaskSheetView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/14/24.
//

import SwiftUI

struct AddTaskSheetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: TagEntity.entity(),
        sortDescriptors: []
    ) private var fetchedTags: FetchedResults<TagEntity>
    
    @Binding var estimatedPomodoros: Int
    @State private var taskTitle: String = ""
    @State private var taskDescription: String = ""
    @State private var selectedTags: Set<Tag> = []
    @Environment(\.presentationMode) var presentationMode
    @State private var tags: [Tag] = []

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Project Name")
                TextField("Enter task title", text: $taskTitle)
                    .accessibilityIdentifier("EnterTaskTitle")
                    .padding()
                    .font(.title3)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                
                Text("Description")
                TextField("What are you working on?", text: $taskDescription)
                    .accessibilityIdentifier("TaskDescription")
                    .padding()
                    .font(.title3)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)

                TagListView(selectedTags: $selectedTags, tags: $tags)
                
                HStack {
                    Text("Est Pomodoros")
                    Stepper(value: $estimatedPomodoros, in: 1...10) {
                        Text("\(estimatedPomodoros)")
                            .frame(minWidth: 36)
                    }
                    .accessibilityIdentifier("PomodorosStepper")
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
                        newTask.tagSet = selectedTags
                        saveContext()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .accessibilityIdentifier("SaveButton")
                    .foregroundStyle(Color.lumenSecondary)
                }
            }
        }
        .padding()
        .onAppear {
            fetchTags()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func fetchTags() {
        let uniqueTags = Set(fetchedTags.map { Tag(id: $0.id!, name: $0.name!, color: $0.color!) })
        tags = Array(uniqueTags)
    }
}

//#Preview {
//    AddTaskSheetView(estimatedPomodoros: .constant(2), tasks: .constant([Task(title: "tesla", description: "implement button", status: "pending", tags: [], pomodoroCount: 2, pomodoroDoneCount: 0, isDone: false)]))
//}
