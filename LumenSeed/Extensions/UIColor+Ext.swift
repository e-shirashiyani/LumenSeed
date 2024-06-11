//
//  UIColor+Ext.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 6/11/24.
//

import Foundation
import UIKit
import SwiftUI

import SwiftUI

extension Color {
    // Convert Color to Hex String
    func toHexString() -> String {
        return UIColor(self).toHexString()
    }
    
    // Convert Hex String to Color
    init?(hex: String) {
        guard let uiColor = UIColor(hex: hex) else {
            return nil
        }
        self.init(uiColor)
    }
}

extension UIColor {
    // Convert UIColor to Hex String
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format: "#%06x", rgb)
    }
    
    // Convert Hex String to UIColor
    convenience init?(hex: String) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexFormatted).scanHexInt64(&rgb) else { return nil }
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
