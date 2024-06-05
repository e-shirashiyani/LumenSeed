//
//  TagListView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/17/24.
//

import SwiftUI
struct TagListView: View {
    @Binding var selectedTags: Set<Tag>
    @State var showingTags: Bool = false
    @Binding var tags: [Tag]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(Array(selectedTags), id: \.self) { tag in
                    TagView(tag: tag) { tagToRemove in
                        selectedTags.remove(tagToRemove)
                    }
                    .padding(.horizontal,6)
                }

                Button(action: {
                    self.showingTags.toggle()
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: "plus")
                            .font(.system(size: 12))
                            .foregroundStyle(.gray.opacity(0.8))
                            
                        Text("Tags")
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)

                    }
                }
                .padding(.all,8)
                .padding(.horizontal,6)
                .background(
                    Capsule()
                        .fill(Color.gray.opacity(0.1))
                )
                .accentColor(.blue) // Replace with your theme color
                .sheet(isPresented: $showingTags) {
                    TagSelectionView(tags: $tags, selectedTags: $selectedTags)
                        .presentationDetents([.medium])  // Controls the height of the presented sheet
                }
                .padding(.leading,6)
            }
        }
    }
}

let sampleTags = [
            Tag(id: UUID(), name: "Work", color: .purple),
            Tag(id: UUID(), name: "Home", color: .blue),
        ]
        let sampleTagSet = Set(sampleTags)

#Preview {
    TagListView(selectedTags: .constant(sampleTagSet), tags: .constant([Tag(id: UUID(), name: "Bussines", color: .green)]))
}
