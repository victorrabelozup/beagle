//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct ScrollViewEntity: WidgetConvertibleEntity {
    
    let children: [AnyDecodableContainer]
    let appearance: AppearanceEntity?
    
    func mapToWidget() throws -> Widget {

        let children = try self.children.compactMap {
            try ($0.content as? WidgetConvertibleEntity)?.mapToWidget()
        }
        let appearance = try self.appearance?.mapToUIModel()

        return ScrollView(
            children: children,
            appearance: appearance
        )
    }
}
