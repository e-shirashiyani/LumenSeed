//
//  PointsView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/13/24.
//

import SwiftUI

struct PointsView: View {
    let points: Int
    
    var body: some View {
        Text("Points\n\(points)")
            .fontWeight(.bold)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
//            .padding()
            .frame(width: 80, height: 60) // Adjust the size as needed
            .background(AppColors.primary)
            .cornerRadius(10) // This creates the square-like shape with rounded corners
        
    }
}



#Preview {
    PointsView(points: 120)
}
