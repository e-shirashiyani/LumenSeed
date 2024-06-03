//
//  TimeLineView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/4/24.
//

import SwiftUI

struct TimeLineView: View {
    var body: some View {
        VStack(alignment: .center,spacing: 50) {
            Text("Your timeline is empty!")
                .font(.largeTitle)
            Image("seed")
                .resizable()
                .scaledToFit()
                .frame(width: 200,height: 200)
            Text("Visit one of the other tabs below to begin growing your productivity!")
                .font(.title3)
//                .frame(width: .infinity)
                .padding(.vertical)
                .multilineTextAlignment(.center)

        }
        .padding([.leading,.trailing],20)
    }
}

#Preview {
    TimeLineView()
}
