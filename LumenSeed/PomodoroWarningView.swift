//
//  WarningView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/5/24.
//

import SwiftUI

struct PomodoroWarningView: View {
    @State private var isPresented = false

    var body: some View {
        NavigationView {
            VStack {
//                Spacer()
                Text("Warning!")
                    .font(.system(size: 40))
                    .fontWeight(.bold)

//                Spacer()
                
                Image("pomodoro-sad") // Make sure you have an image asset named 'pomodoro'.
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 300)
                
                Text("If you quit, you will cause 20% damage to your pomodoro’s health!")
                    .font(.headline)
                    .foregroundColor(AppColors.secondry)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,30)
                
//                Spacer()

                HStack {
//                    Button("Cancel") {
//                        // Action for Cancel
//                        self.isPresented = false
//                    }
//                    .foregroundColor(.red)
//                    .padding()
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.red, lineWidth: 2)
//                    )
                    Button("Cancel") {  }
                        .buttonStyle(PrimaryButtonStyle(backgroundColor: .clear, foregroundColor: AppColors.secondry, width: 140))
                    
                    Button("Quit") {  }
                        .buttonStyle(PrimaryButtonStyle(backgroundColor: AppColors.primary, foregroundColor: .white, width: 140))
                    
//                    Button("Quit") {
//                        // Action for Quit
//                    }
//                    .foregroundColor(.blue)
//                    .padding()
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.blue, lineWidth: 2)
//                    )
                }
                
//                .padding(.bottom, /*50*/)
//                Spacer()
            }
            .padding()
            
        }
        .alert(isPresented: $isPresented) {
            Alert(
                title: Text("Are you sure you want to quit?"),
                primaryButton: .destructive(Text("Quit")) {
                    // Confirm quit action
                },
                secondaryButton: .cancel()
            )
        }
    }
}

#Preview {
    PomodoroWarningView()
}
