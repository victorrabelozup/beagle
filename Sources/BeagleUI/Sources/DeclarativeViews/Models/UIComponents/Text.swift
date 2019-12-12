//
//  Text.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct Text: NativeWidget {
    
    // MARK: - Public Properties
    
    public let text: String
    public let style: String?
    public let alignment: Alignment?
    
    public init(
        _ text: String,
        style: String? = nil,
        alignment: Alignment? = nil
    ) {
        self.text = text
        self.style = style
        self.alignment = alignment
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
