//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ButtonEntity: ComponentConvertibleEntity {
    
    let text: String
    
    var style: String?
    var appearance: AppearanceEntity?
    var flex: FlexEntity?
    
    init(text: String, style: String? = nil, appearance: AppearanceEntity? = nil, flex: FlexEntity? = nil) {
        self.text = text
        self.style = style
        self.appearance = appearance
        self.flex = flex
    }
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let appearance = try self.appearance?.mapToUIModel()
        let flex = try self.flex?.mapToUIModel()
        return Button(text: text, style: style, appearance: appearance, flex: flex)
    }
}
