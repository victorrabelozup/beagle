//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct Text: Widget, HasAppearance {
    
    // MARK: - Public Properties
    
    public let text: String
    public let style: String?
    public let alignment: Alignment?
    public let appearance: Appearance?
    
    public init(
        _ text: String,
        style: String? = nil,
        alignment: Alignment? = nil,
        appearance: Appearance? = nil
    ) {
        self.text = text
        self.style = style
        self.alignment = alignment
        self.appearance = appearance
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
