//
//  AddTaskSheetView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/14/24.
//

import SwiftUI
import CoreData
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
                VStack(alignment: .leading) {
                    Text("What would you like to do?")
                    TextField("e.g.,Meeting With Alex", text: $taskTitle)
                        .accessibilityIdentifier("EnterTaskTitle")
                        .padding(.all,10)
                        .font(.title3)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding(.top)
                
                VStack(alignment: .leading) {
                    Text("Description")
                    TextField("", text: $taskDescription)
                        .accessibilityIdentifier("TaskDescription")
                        .padding(.all,10)
                        .font(.title3)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
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
            .navigationBarTitle("Seed", displayMode: .inline)
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
                    .foregroundStyle(taskTitle.isEmpty ? .gray : Color.lumenSecondary)
                    .disabled(taskTitle.isEmpty)
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


