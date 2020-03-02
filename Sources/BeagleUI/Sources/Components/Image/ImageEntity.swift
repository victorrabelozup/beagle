//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct ImageEntity: WidgetEntity {
    let name: String
    let contentMode: ImageEntityContentMode?
    
    var id: String?
    let accessibility: AccessibilityEntity?
    var appearance: AppearanceEntity?
    var flex: FlexEntity?
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let contentMode = try self.contentMode?.mapToUIModel(ofType: ImageContentMode.self)
        let appearance = try self.appearance?.mapToUIModel()
        let accessibility = try self.accessibility?.mapToUIModel()
        let flex = try self.flex?.mapToUIModel()
        return Image(name: name, contentMode: contentMode, id: id, appearance: appearance, flex: flex, accessibility: accessibility)
    }
}
