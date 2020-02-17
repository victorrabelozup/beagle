//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct Text: Widget {
    
    // MARK: - Public Properties
    
    public let text: String
    public let style: String?
    public let alignment: Alignment?
    public let appearance: Appearance?
    public let flex: Flex?
    
    public init(
        _ text: String,
        style: String? = nil,
        alignment: Alignment? = nil,
        appearance: Appearance? = nil,
        flex: Flex? = nil
    ) {
        self.text = text
        self.style = style
        self.alignment = alignment
        self.appearance = appearance
        self.flex = flex
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
        
        label.applyAppearance(appearance)
        dependencies.flex.setupFlex(flex, for: label)
        
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
