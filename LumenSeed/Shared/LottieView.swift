//
//  LottieView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 6/3/24.
//

import SwiftUI

import Lottie

struct LottieView: UIViewRepresentable {
    var filename: String

    func makeUIView(context: Context) -> some UIView {
        let view = LottieAnimationView(name: filename)
        view.loopMode = .playOnce
        view.play()
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
#Preview {
    LottieView(filename: "")
}
