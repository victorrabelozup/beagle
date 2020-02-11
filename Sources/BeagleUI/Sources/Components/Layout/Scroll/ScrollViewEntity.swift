//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct ScrollViewEntity: ComponentConvertibleEntity {
    
    let children: [AnyDecodableContainer]
    let appearance: AppearanceEntity?
    
    func mapToComponent() throws -> ServerDrivenComponent {

        let children = try self.children.compactMap {
            try ($0.content as? ComponentConvertibleEntity)?.mapToComponent()
        }
        let appearance = try self.appearance?.mapToUIModel()

        return ScrollView(
            children: children,
            appearance: appearance
        )
    }
}
