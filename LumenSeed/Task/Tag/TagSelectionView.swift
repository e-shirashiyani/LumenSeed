//
//  TagSelectionView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/16/24.
//

import SwiftUI

struct TagSelectionView: View {
    @Binding var tags: [Tag]  // Binding to the list of tags
    @Binding var selectedTags: Set<Tag>
    @State private var showingCreateTag = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            
            VStack {
                ZStack {
                    Color.white
                    List {
                        ForEach(tags) { tag in
                            HStack {
                                Circle()
                                    .fill(tag.color)
                                    .frame(width: 20, height: 20)
                                Text(tag.name)
                                    .padding(.leading,6)
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
                            .padding(.vertical,6)
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
                                    .padding(.leading,8)
                            }
                            
                        }
                        .padding(.top,8)
                        
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
                        .buttonStyle(CapsuleButtonStyle(backgroundColor: .lumenGreen,foregroundColor: .white))
                    }
                    .padding(.horizontal,20)
                    .padding(.top,300)
                    
                    
                }
            }
                    .background(.white)
            .sheet(isPresented: $showingCreateTag) {
                TagCreationView(tags: $tags)
            }
            .navigationTitle("Tags")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



#Preview {
    TagSelectionView(tags: .constant([
        Tag(id: UUID(), name: "Work", color: .blue),
        Tag(id: UUID(), name: "Personal", color: .green),
        Tag(id: UUID(), name: "Important", color: .red)
    ]), selectedTags: .constant([]))
}
