//
//  PrimaryButtonStyle.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/13/24.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var foregroundColor: Color
    var width: CGFloat
    var isOutline: Bool = false

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: width, height: 50)
            .background(isOutline ? Color.clear : backgroundColor)
            .foregroundColor(foregroundColor)
            .overlay(
                isOutline ? Capsule().stroke(foregroundColor, lineWidth: 2) : nil
            )
            .clipShape(Capsule())
            .font(.title2)
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .padding(.top,40)
    }
}


//#Preview {
//    PrimaryButtonStyle(backgroundColor: .blue, foregroundColor: .white, width: 100)
//}
