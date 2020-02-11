//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct TextEntity: ComponentConvertibleEntity {
    
    let text: String
    var style: String?
    let alignment: AlignmentEntity?
    let appearance: AppearanceEntity?
    let flex: FlexEntity?
    
    init(
        text: String,
        style: String? = nil,
        alignment: AlignmentEntity? = nil,
        appearance: AppearanceEntity? = nil,
        flex: FlexEntity? = nil
    ) {
        self.text = text
        self.style = style
        self.alignment = alignment
        self.appearance = appearance
        self.flex = flex
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
            appearance: try appearance?.mapToUIModel(),
            flex: try flex?.mapToUIModel()
        )
    }
}
