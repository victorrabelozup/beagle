//
//  Copyright © 30/12/19 Zup IT. All rights reserved.
//

import UIKit

extension UIView {
    public func applyAppearance(_ appearance: Appearance?) {
        if let hex = appearance?.backgroundColor {
            backgroundColor = .init(hex: hex)
        }
        if let cornerRadius = appearance?.cornerRadius {
            layer.masksToBounds = true
            layer.cornerRadius = CGFloat(cornerRadius.radius)
        }
    }
}

extension UIColor {
    
    /// Create a color from hex String.
    /// Format: [#][AA]RRGGBB
    convenience init(hex: String) {
        let hexDigits = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hexDigits).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hexDigits.count {
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
    
}
