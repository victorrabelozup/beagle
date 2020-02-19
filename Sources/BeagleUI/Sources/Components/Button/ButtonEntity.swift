//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ButtonEntity: WidgetEntity {
    
    let text: String
    var style: String?
    var appearance: AppearanceEntity?
    var flex: FlexEntity?
    let accessibility: AccessibilityEntity?
    
    init(
        text: String,
        style: String? = nil,
        appearance: AppearanceEntity? = nil,
        flex: FlexEntity? = nil,
        accessibility: AccessibilityEntity? = nil
    ) {
        self.text = text
        self.style = style
        self.appearance = appearance
        self.flex = flex
        self.accessibility = accessibility
    }
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let appearance = try self.appearance?.mapToUIModel()
        let flex = try self.flex?.mapToUIModel()
        let accessibility = try self.accessibility?.mapToUIModel()
        return Button(text: text, style: style, appearance: appearance, flex: flex, accessibility: accessibility)
    }
}
