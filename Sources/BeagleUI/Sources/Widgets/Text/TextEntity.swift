//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct TextEntity: WidgetConvertibleEntity {
    
    let text: String
    var style: String?
    let alignment: AlignmentEntity?
    let appearance: AppearanceEntity?
    
    init(
        text: String,
        style: String? = nil,
        alignment: AlignmentEntity? = nil,
        appearance: AppearanceEntity? = nil
    ) {
        self.text = text
        self.style = style
        self.alignment = alignment
        self.appearance = appearance
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
        return Text(
            text,
            style: style,
            alignment: try alignment?.mapToUIModel(ofType: Text.Alignment.self),
            appearance: try appearance?.mapToUIModel()
        )
    }
}
