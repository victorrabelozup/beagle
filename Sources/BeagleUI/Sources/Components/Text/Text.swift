//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct Text: Widget {
    
    // MARK: - Public Properties
    
    public let text: String
    public let style: String?
    public let alignment: Alignment?
    public let textColor: String?
    public var id: String?
    public let appearance: Appearance?
    public let flex: Flex?
    public let accessibility: Accessibility?
    
    public init(
        _ text: String,
        style: String? = nil,
        alignment: Alignment? = nil,
        textColor: String? = nil,
        id: String? = nil,
        appearance: Appearance? = nil,
        flex: Flex? = nil,
        accessibility: Accessibility? = nil
    ) {
        self.text = text
        self.style = style
        self.alignment = alignment
        self.textColor = textColor
        self.id = id
        self.appearance = appearance
        self.flex = flex
        self.accessibility = accessibility
    }
}

extension Text: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let label = UILabel(frame: .zero)
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = alignment?.toUIKit() ?? .natural
        if let style = style {
            dependencies.theme.applyStyle(for: label, withId: style)
        }
        if let color = textColor {
            label.textColor = UIColor(hex: color)
        }

        label.applyAccessibilityIdentifier(id)
        label.applyAppearance(appearance)
        label.flex.setupFlex(flex)
        dependencies.accessibility.applyAccessibilityAttributes(accessibility, to: label)
        
        return label
    }
}

extension Text {
    public enum Alignment: String, StringRawRepresentable {
        case left = "LEFT"
        case right = "RIGHT"
        case center = "CENTER"
        
        func toUIKit() -> NSTextAlignment {
            switch self {
            case .left:
                return .left
            case .right:
                return .right
            case .center:
                return .center
            }
        }
    }
}
