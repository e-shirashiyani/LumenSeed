//
//  TagSelectionView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/16/24.
//

import SwiftUI
import CoreData

struct TagSelectionView: View {
    @Binding var tags: [Tag]  // Binding to the list of tags
    @Binding var selectedTags: Set<Tag>
    @State private var showingCreateTag = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color.white
                    List {
                        ForEach(tags, id: \.id) { tag in  // Use id to uniquely identify tags
                            HStack {
                                Circle()
                                    .fill(Color(hex: tag.color) ?? .blue)
                                    .frame(width: 20, height: 20)
                                Text(tag.name)
                                    .padding(.leading, 6)
                                    .font(.system(size: 16))

                                Spacer()

                                if selectedTags.contains(tag) {
                                    Circle()
                                        .fill(Color.green)
                                        .frame(width: 20, height: 20)
                                } else {
                                    Circle()
                                        .strokeBorder(Color.gray, lineWidth: 2)
                                        .background(Circle().fill(Color.clear))
                                        .frame(width: 20, height: 20)
                                }
                            }
                            .padding(.vertical, 6)
                            .onTapGesture {
                                if selectedTags.contains(tag) {
                                    selectedTags.remove(tag)  // Deselect if already selected
                                } else {
                                    selectedTags.insert(tag)  // Select if not selected
                                }
                            }
                            .listRowBackground(selectedTags.contains(tag) ? Color.green.opacity(0.2) : Color.clear)
                        }
                        .listRowSeparator(.hidden)

                        Button(action: {
                            self.showingCreateTag.toggle()
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                    .foregroundStyle(.lumenGreen)
                                    .font(.title3)
                                    .fontWeight(.medium)

                                Text("New Tag")
                                    .foregroundStyle(.lumenGreen)
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .padding(.leading, 8)
                            }
                        }
                        .padding(.top, 8)
                        .listRowBackground(Color.clear)
                        .listStyle(.automatic)
                    }
                    Spacer()

                    HStack(spacing: 20) {
                        Button("Cancel") {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .buttonStyle(CapsuleButtonStyle(backgroundColor: .gray.opacity(0.2), foregroundColor: .lumenSecondary))

                        Button("Done") {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .buttonStyle(CapsuleButtonStyle(backgroundColor: .lumenGreen, foregroundColor: .white))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 300)
                }
            }
            .background(.white)
            .sheet(isPresented: $showingCreateTag) {
                TagCreationView(tags: $tags, onSave: {
                    fetchTags()
                })
            }
            .navigationTitle("Tags")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                fetchTags()
            }
        }
    }

    private func fetchTags() {
        let request: NSFetchRequest<TagEntity> = TagEntity.fetchRequest()
        do {
            let fetchedTags = try viewContext.fetch(request)
            // Use a Set to ensure uniqueness based on tag name
            var uniqueTags = Set<String>()
            self.tags = fetchedTags.compactMap { tagEntity in
                guard let name = tagEntity.name,
                      let colorHex = tagEntity.color,
                      !uniqueTags.contains(name) else {
                    return nil
                }
                uniqueTags.insert(name)
                return Tag(id: tagEntity.id!, name: name, color: colorHex)
            }
        } catch {
            print("Failed to fetch tags: \(error.localizedDescription)")
        }
    }
}

#Preview {
    TagSelectionView(tags: .constant([
        Tag(id: UUID(), name: "Work", color: ""),
        Tag(id: UUID(), name: "Personal", color: ""),
        Tag(id: UUID(), name: "Important", color: "")
    ]), selectedTags: .constant([]))
}
