//
//  TagCreationView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/16/24.
//

import SwiftUI
import CoreData

struct TagCreationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var tags: [Tag]
    @State private var tagName: String = ""
    @State private var selectedColor: Color = .blue
    @Environment(\.presentationMode) var presentationMode
    let colors: [Color] = [.red, .green, .blue, .orange, .purple, .brown, .cyan, .black, .gray, .indigo, .yellow, .mint, .pink, .lumenSecondary, .lumenGreen]

    var onSave: () -> Void

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Circle()
                        .fill(selectedColor)
                        .frame(width: 20, height: 20)

                    TextField("Tag name", text: $tagName)
                        .textFieldStyle(.plain)
                        .padding(.all, 6)
                }
                .padding(.all, 8)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.1))

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 40, height: 50)
                            .overlay(
                                ZStack {
                                    if selectedColor == color {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.white)
                                            .font(.system(size: 15))
                                    }
                                }
                            )
                            .onTapGesture {
                                self.selectedColor = color
                            }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))

                Spacer()
            }
            .navigationTitle("New Tag")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        saveTag()
                    }
                    .foregroundStyle(.gray)
                }
            }
        }
    }

    private func saveTag() {
        let request: NSFetchRequest<TagEntity> = TagEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", tagName)
        
        do {
            let existingTags = try viewContext.fetch(request)
            if existingTags.isEmpty {
                let newTag = TagEntity(context: viewContext)
                newTag.id = UUID()
                newTag.name = tagName
                newTag.color = selectedColor.toHexString()
                try viewContext.save()
                fetchTags()
                onSave() // Notify about the save
            } else {
                // Handle the case where the tag already exists
                print("Tag already exists.")
            }
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        self.presentationMode.wrappedValue.dismiss()
    }

    private func fetchTags() {
        let request: NSFetchRequest<TagEntity> = TagEntity.fetchRequest()
        do {
            let fetchedTags = try viewContext.fetch(request)
            let uniqueTags = Set(fetchedTags.map { Tag(id: $0.id!, name: $0.name!, color: $0.color!) })
            self.tags = Array(uniqueTags)
        } catch {
            print("Failed to fetch tags: \(error.localizedDescription)")
        }
    }
}
//#Preview {
//    TagCreationView(tags: .constant([Tag(id: UUID(), name: "Bussines", color: .blue)]))
//}
