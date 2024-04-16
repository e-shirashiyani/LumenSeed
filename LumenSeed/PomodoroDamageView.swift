//
//  PomodoroDamageView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/5/24.
//

import SwiftUI

struct PomodoroDamageView: View {
    @State private var isPresented = false
    @State private var health: CGFloat = 0.8 // 80% health

    var body: some View {
//        NavigationView {
            VStack {
                Spacer(minLength: 60)
                Text("Oh no!")
                    .font(.system(size: 40))
                    .fontWeight(.bold)


                Image("pomodoro-cry")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 300)
                Spacer(minLength: 40)
                Text("Your pomodoro received \n 20% damage")
                    .font(.title2)
                    .foregroundColor(AppColors.primary)
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                    .padding(.horizontal,30)
                
                Spacer(minLength: 30)
                
                HStack {
                    Text("Health")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(AppColors.primary)
//                        .frame(maxWidth: .infinity)
                    Spacer()
                    
                    Text("80%")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(AppColors.primary)

//                        .frame(maxWidth: .infinity)
                }

               GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(width: geometry.size.width , height: 10)
                                        .opacity(0.3)
                                        .foregroundColor(Color(UIColor.red.withAlphaComponent(0.4)))

                                Rectangle()
                                    .frame(width: min(CGFloat(self.health)*geometry.size.width, geometry.size.width), height: 10)
                                    .foregroundColor(AppColors.primary)
                                        .animation(.linear, value: health)
                                }
                                .cornerRadius(45.0)
                            }
                }
//            .foregroundColor(.gray)
            .padding()
            
        }
//        .alert(isPresented: $isPresented) {
//            Alert(
//                title: Text("Are you sure you want to quit?"),
//                primaryButton: .destructive(Text("Quit")) {
//                    // Confirm quit action
//                },
//                secondaryButton: .cancel()
//            )
//        }
//    }
}

#Preview {
    PomodoroDamageView()
}
