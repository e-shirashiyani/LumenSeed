//
//  TabBar+Ext.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/3/24.
//

import UIKit
import SwiftUI
extension UITabBar {
    static func configureTabBarAppearance(cornerRadius: CGFloat, backgroundColor: UIColor) {
        let appearance = UITabBarAppearance()
        
        // Create a resizable background image with corner radius
        let backgroundImage = UIImage.createRoundedCornerImage(cornerRadius: cornerRadius, color: backgroundColor)
        
        appearance.backgroundImage = backgroundImage
        appearance.backgroundEffect = nil // Optional: Adjust for transparency
        
        // Set appearance for different iOS versions
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
