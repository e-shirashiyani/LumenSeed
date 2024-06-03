//
//  TagCreationView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/16/24.
//

import SwiftUI

struct TagCreationView: View {
    @Binding var tags: [Tag]
    @State private var tagName: String = ""
    @State private var selectedColor: Color = .blue
    @Environment(\.presentationMode) var presentationMode
    let colors: [Color] = [.red, .green, .blue, .orange, .purple, .brown, .cyan, .black, .gray, .indigo , .yellow, .mint , .pink, .lumenSecondary, .lumenGreen]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("")
                    .frame(maxWidth: .infinity,maxHeight: 15)
                    .background(.white)
                HStack {
                    Circle()
                        .fill(selectedColor)
                        .frame(width: 20,height: 20)
                        
                    TextField("Tag name", text: $tagName)
                        .textFieldStyle(.plain)
                        .padding(.all,6)
                    
                }
                .padding(.all,8)
                .padding(.horizontal)
                .background(.gray.opacity(0.1))
                
                Text("")
                    .frame(maxWidth: .infinity,maxHeight: 10)
                    .background(.white)
                
                // Color Picker
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 40, height: 50)
                            .overlay(
                                // Check if this color is the selected one and overlay a checkmark
                                ZStack {
                                    if selectedColor == color {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.white)
                                            .font(.system(size: 15)) // You can adjust the size accordingly
                                    }
                                }
                            )
                            .onTapGesture {
                                self.selectedColor = color
                            }
                    }
                }
                .padding()
                .background(.gray.opacity(0.1))
                
                
                Spacer()
            }
            .navigationTitle("New Tag")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.gray.opacity(0.1), for: .navigationBar)
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        let newTag = Tag(id: UUID(), name: tagName, color: selectedColor)
                        self.tags.append(newTag)
                        self.presentationMode.wrappedValue.dismiss()

                    }
                    .foregroundStyle(.gray)
                    
                }
            }
        }
        
    }
}


#Preview {
    TagCreationView(tags: .constant([Tag(id: UUID(), name: "Bussines", color: .blue)]))
}
