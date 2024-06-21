//
//  EditTaskSheetView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 6/21/24.
//

import SwiftUI

import SwiftUI
import CoreData

struct EditTaskSheetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var task: TaskEntity
    @Environment(\.presentationMode) var presentationMode

    @FetchRequest(
        entity: TagEntity.entity(),
        sortDescriptors: []
    ) private var fetchedTags: FetchedResults<TagEntity>
    
    @State private var selectedTags: Set<Tag> = []
    @State private var tags: [Tag] = []

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Project Name")
                TextField("Enter task title", text: Binding(
                    get: { task.title ?? "" },
                    set: { task.title = $0 }
                ))
                    .padding()
                    .font(.title3)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)

                Text("Description")
                TextField("What are you working on?", text: Binding(
                    get: { task.taskDescription ?? "" },
                    set: { task.taskDescription = $0 }
                ))
                    .padding()
                    .font(.title3)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)

                TagListView(selectedTags: $selectedTags, tags: $tags)

                HStack {
                    Text("Est Pomodoros")
                    Stepper(value: Binding(
                        get: { Int(task.pomodoroCount) },
                        set: { task.pomodoroCount = Int32($0) }
                    ), in: 1...10) {
                        Text("\(task.pomodoroCount)")
                            .frame(minWidth: 36)
                    }
                }
                .padding(.all, 4)

                Spacer()
            }
            .navigationBarTitle("Edit Task", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
//                    .foregroundStyle(.gray)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        task.tagSet = selectedTags
                        saveContext()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundStyle(.gray)
                }
            }
        }
        .padding()
        .onAppear {
            fetchTags()
            loadSelectedTags()
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

    private func loadSelectedTags() {
        if let taskTags = task.tagSet as? Set<Tag> {
            selectedTags = taskTags
        }
    }
}
//#Preview {
//    EditTaskSheetView()
//}
