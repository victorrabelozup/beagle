//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ContainerEntity: WidgetConvertibleEntity {
    
    var children: [AnyDecodableContainer] = []
    var flex: FlexEntity?
    var appearance: AppearanceEntity?

    init(
        children: [AnyDecodableContainer] = [],
        flex: FlexEntity? = nil,
        appearance: AppearanceEntity? = nil
    ) {
        self.children = children
        self.flex = flex
        self.appearance = appearance
    }
    
    func mapToWidget() throws -> Widget {
        let children = try self.children.compactMap {
            try ($0.content as? WidgetConvertibleEntity)?.mapToWidget()
        }
        let flex = try self.flex?.mapToUIModel() ?? Flex()
        let appearance = try self.appearance?.mapToUIModel()
        
        return Container(
            children: children,
            flex: flex,
            appearance: appearance
        )
    }
}
