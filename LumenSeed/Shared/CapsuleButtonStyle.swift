//
//  CapsuleButtonStyle.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/18/24.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var foregroundColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .fontWeight(.medium)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}


#Preview {
    Button("Sample Button") {
                // action for the sample button
            }
    .buttonStyle(CapsuleButtonStyle(backgroundColor: .lumenGreen, foregroundColor: .white))
            .previewLayout(.sizeThatFits)
            .padding()
}
