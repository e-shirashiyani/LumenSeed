//
//  LaunchScreenView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/3/24.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        VStack {
            ZStack {
                Color.white.ignoresSafeArea()

                Spacer()
                HStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400, height: 400)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
