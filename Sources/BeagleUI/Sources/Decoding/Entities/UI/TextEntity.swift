//
//  TextEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct TextEntity: WidgetConvertibleEntity {
    
    let text: String
    var style: String?
    let alignment: AlignmentEntity?
    
    init(text: String, style: String? = nil, alignment: AlignmentEntity? = nil) {
        self.text = text
        self.style = style
        self.alignment = alignment
    }

    public enum AlignmentEntity: String, Decodable, UIEnumModelConvertible {
        case left = "LEFT"
        case right = "RIGHT"
        case center = "CENTER"
        
        func toAlignment() -> Text.Alignment {
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
    
    func mapToWidget() throws -> Widget {
        return Text(text, style: style, alignment: try alignment?.mapToUIModel(ofType: Text.Alignment.self))
    }
}
