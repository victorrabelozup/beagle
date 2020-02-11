//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct ImageEntity: ComponentConvertibleEntity {
    let name: String
    let contentMode: ImageEntityContentMode?
    
    var appearance: AppearanceEntity?
    var flex: FlexEntity?
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let contentMode = try self.contentMode?.mapToUIModel(ofType: ImageContentMode.self)
        let appearance = try self.appearance?.mapToUIModel()
        let flex = try self.flex?.mapToUIModel()
        return Image(name: name, contentMode: contentMode, appearance: appearance, flex: flex)
    }
}
