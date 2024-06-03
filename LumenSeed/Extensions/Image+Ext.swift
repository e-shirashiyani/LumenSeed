//
//  Image+Ext.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/3/24.
//

import UIKit
extension UIImage {
    static func createRoundedCornerImage(cornerRadius: CGFloat, color: UIColor, size: CGSize = CGSize(width: 10, height: 10)) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            color.setFill()
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            path.fill()
        }.resizableImage(withCapInsets: UIEdgeInsets(top: cornerRadius, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
    }
}
