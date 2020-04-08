/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .clear
        
        textView.textAlignment = alignment?.toUIKit() ?? .natural
        textView.text = text
        
        if let style = style {
            dependencies.theme.applyStyle(for: textView, withId: style)
        }
        if let color = textColor {
            textView.textColor = UIColor(hex: color)
        }

        textView.beagle.setup(self)
        
        return textView
    }
}

extension Text {
    public enum Alignment: String, Decodable {
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
