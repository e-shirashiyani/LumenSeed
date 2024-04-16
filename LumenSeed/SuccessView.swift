//
//  SuccessView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/8/24.
//

import SwiftUI

import SwiftUI

struct SuccessView: View {
    var body: some View {
        HStack{
            Spacer()
            PointsView(points: 120)

        }
        VStack(spacing: 20) {
           
            Spacer()
            

            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.green)

            Text("Success!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top,-2)

            Text("Snake plant was added to your garden! You spent 90 points. You have still have 30 points")
                .multilineTextAlignment(.center)
                .padding()

            Button(action: {
                // Action to tend to your garden
            }) {
                Text("Tend to your garden!")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColors.primary)
                    .cornerRadius(25)
                    .padding(.leading,32)
                    .padding(.trailing,32)

            }            
            .padding(.top,68)


            Button(action: {
                // Action to undo the addition
            }) {
                Text("Undo")
                    .foregroundColor(AppColors.secondry)
            }

            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
}


#Preview {
    SuccessView()
}
