//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ContainerEntity: WidgetEntity {

    var children: [AnyDecodableContainer] = []
    
    var id: String?
    var flex: FlexEntity?
    var appearance: AppearanceEntity?
    let accessibility: AccessibilityEntity?
    
    init(
        children: [AnyDecodableContainer] = [],
        id: String? = nil,
        flex: FlexEntity? = nil,
        appearance: AppearanceEntity? = nil,
        accessibility: AccessibilityEntity? = nil
    ) {
        self.children = children
        self.id = id
        self.flex = flex
        self.appearance = appearance
        self.accessibility = accessibility
    }
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let children = try self.children.compactMap {
            try ($0.content as? ComponentConvertibleEntity)?.mapToComponent()
        }
        let flex = try self.flex?.mapToUIModel() ?? Flex()
        let appearance = try self.appearance?.mapToUIModel()
        let accessibility = try self.accessibility?.mapToUIModel()
        
        return Container(
            children: children,
            id: id,
            flex: flex,
            appearance: appearance,
            accessibility: accessibility
        )
    }
}
