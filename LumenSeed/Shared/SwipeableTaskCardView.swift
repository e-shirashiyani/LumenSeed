//
//  SwipeableTaskCardView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 6/3/24.
//

import SwiftUI

struct SwipeableTaskCardView: View {
    let task: Task
    let onDelete: () -> Void
    @State private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                if offset.width < -50 { // Show delete button when swiped enough
                    Button(action: {
                        onDelete()
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    .padding(.trailing, 20)
                }
            }
            
            TaskCardView(task: task)
                .offset(x: offset.width)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.width < 0 {
                                self.offset = gesture.translation
                            }
                        }
                        .onEnded { _ in
                            if self.offset.width < -100 {
                                withAnimation {
                                    self.offset = .zero
                                    onDelete()
                                }
                            } else {
                                withAnimation {
                                    self.offset = .zero
                                }
                            }
                        }
                )
        }
    }
}
