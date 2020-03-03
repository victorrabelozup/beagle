//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ButtonEntity: WidgetEntity {
    
    let text: String
    var style: String?
    let action: AnyDecodableContainer?
    
    var id: String?
    var appearance: AppearanceEntity?
    var flex: FlexEntity?
    let accessibility: AccessibilityEntity?
    
    init(
        text: String,
        style: String? = nil,
        appearance: AppearanceEntity? = nil,
        id: String? = nil,
        flex: FlexEntity? = nil,
        accessibility: AccessibilityEntity? = nil,
        action: AnyDecodableContainer? = nil
    ) {
        self.text = text
        self.style = style
        self.id = id
        self.appearance = appearance
        self.flex = flex
        self.accessibility = accessibility
        self.action = action
    }
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let actionEntity = self.action?.content as? ActionConvertibleEntity
        
        let appearance = try self.appearance?.mapToUIModel()
        let flex = try self.flex?.mapToUIModel()
        let accessibility = try self.accessibility?.mapToUIModel()
        let action = try actionEntity?.mapToAction()
        
        return Button(text: text, style: style, action: action, id: id, appearance: appearance, flex: flex, accessibility: accessibility)
    }
}
