//
//  ProgressCircleView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/4/24.
//

import SwiftUI

import SwiftUI
import SwiftUI

struct ProgressCircleView: View {
    @Binding var totalTime: CGFloat // Total time in seconds, now as a binding
    @Binding var timeRemaining: CGFloat // Time remaining in seconds, now as a binding

    var progress: CGFloat {
        return timeRemaining / totalTime
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)

            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(AppColors.primary)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { gesture in
                            self.calculateTime(from: gesture.location)
                        }
                )
            
//            Image("seed") // Make sure this image is available in your asset catalog
//                .foregroundColor(AppColors.primary)
            
            Text(timeString(time: timeRemaining))
                .font(.system(size: 50))
                .bold()
                .padding(.top, 20)
        }
        .frame(width: 300, height: 300)
        .padding(.top, 30)
    }
    
    // Converts time in seconds to a string formatted as mm:ss
    func timeString(time: CGFloat) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // Calculate time remaining based on the touch location
    private func calculateTime(from location: CGPoint) {
        let center = CGPoint(x: 150, y: 150) // Center point of the circle
        let angle = atan2(location.y - center.y, location.x - center.x) + .pi / 2.0
        var progress = angle / (2 * .pi)
        if progress < 0 { progress += 1 } // Normalize the progress
        let newTime = progress * totalTime
        timeRemaining = max(0, newTime) // Ensure time remaining is not negative
    }
}

#Preview {
    ProgressCircleView(totalTime: .constant(300), timeRemaining: .constant(150 * 60)) // Preview with 150 minutes remaining
}
