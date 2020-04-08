/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
    
    public static func text(font: UIFont, color: UIColor) -> (UITextView?) -> Void {
        return {
            $0?.font = font
            $0?.textColor = color
        }
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
    
    public static func tabView(backgroundColor: UIColor, indicatorColor: UIColor, selectedTextColor: UIColor? = nil, unselectedTextColor: UIColor? = nil, selectedIconColor: UIColor? = nil, unselectedIconColor: UIColor? = nil) -> (UIView?) -> Void {
        return {
            guard let tabView = $0 as? TabViewUIComponent else { return }
            tabView.collectionView.backgroundColor = backgroundColor
            tabView.containerIndicator.indicatorView.backgroundColor = indicatorColor
            tabView.model.selectedTextColor = selectedTextColor
            tabView.model.unselectedTextColor = unselectedTextColor
            tabView.model.selectedIconColor = selectedIconColor
            tabView.model.unselectedIconColor = unselectedIconColor
        }
    }

}
