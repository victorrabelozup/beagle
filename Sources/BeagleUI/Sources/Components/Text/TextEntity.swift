//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct TextEntity: WidgetEntity {
    
    let text: String
    var style: String?
    let alignment: AlignmentEntity?
    let textColor: String?
    
    var id: String?
    let appearance: AppearanceEntity?
    let flex: FlexEntity?
    let accessibility: AccessibilityEntity?
    
    init(
        text: String,
        style: String? = nil,
        alignment: AlignmentEntity? = nil,
        textColor: String? = nil,
        id: String? = nil,
        appearance: AppearanceEntity? = nil,
        flex: FlexEntity? = nil,
        accessibility: AccessibilityEntity? = nil
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
    
    func mapToComponent() throws -> ServerDrivenComponent {
        return Text(
            text,
            style: style,
            alignment: try alignment?.mapToUIModel(ofType: Text.Alignment.self),
            textColor: textColor,
            id: id,
            appearance: try appearance?.mapToUIModel(),
            flex: try flex?.mapToUIModel(),
            accessibility: try accessibility?.mapToUIModel()
        )
    }
}
