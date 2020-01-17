//
//  FunctionalTheme.swift
//  BeagleUI
//
//  Created by Daniel Tes on 08/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public protocol Theme {
    func applyStyle<T: UIView>(for view: T, withId id: String)
}

public protocol DependencyTheme {
    var theme: Theme { get }
}

public protocol DependencyAppBundle {
    var appBundle: Bundle { get }
}

public struct AppTheme: Theme {
    let styles: [String: Any]
    
    public init(
        styles: [String: Any]
    ) {
        self.styles = styles
    }

    public func applyStyle<T: UIView>(for view: T, withId id: String) {
        if let styleFunc = styles[id] as? (() -> (T?) -> Void) {
            view |> styleFunc()
        }
    }
}

public struct BeagleStyle {
    public static func backgroundColor(withColor color: UIColor) -> (UIView?) -> Void {
        return { $0?.backgroundColor = color }
    }

    public static func label(withFont font: UIFont) -> (UILabel?) -> Void {
        return { $0?.font = font }
    }

    public static func label(withTextColor color: UIColor) -> (UILabel?) -> Void {
        return { $0?.textColor = color }
    }

    public static func label(font: UIFont, color: UIColor) -> (UILabel?) -> Void {
        return label(withFont: font)
            <> label(withTextColor: color)
    }
    
    public static func button(withTitleColor color: UIColor) -> (UIButton?) -> Void {
        return { $0?.setTitleColor(color, for: .normal) }
    }
}
