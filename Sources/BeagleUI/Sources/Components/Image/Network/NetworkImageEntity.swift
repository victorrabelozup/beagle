//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct NetworkImageEntity: WidgetEntity {
    var id: String?
    
    let path: String
    let contentMode: ImageEntityContentMode?
    let appearance: AppearanceEntity?
    var flex: FlexEntity?
    var accessibility: AccessibilityEntity?
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let contentMode = try self.contentMode?.mapToUIModel(ofType: ImageContentMode.self)
        let appearance = try self.appearance?.mapToUIModel()
        let accessibility = try self.accessibility?.mapToUIModel()
        let flex = try self.flex?.mapToUIModel()
        return NetworkImage(path: path, contentMode: contentMode, id: id, appearance: appearance, flex: flex, accessibility: accessibility)
    }
}
