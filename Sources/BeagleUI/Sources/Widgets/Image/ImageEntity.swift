//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct ImageEntity: WidgetConvertibleEntity {
    let name: String
    let contentMode: ImageEntityContentMode?
    let appearance: AppearanceEntity?
    
    func mapToWidget() throws -> Widget {
        let contentMode = try self.contentMode?.mapToUIModel(ofType: ImageContentMode.self)
        let appearance = try self.appearance?.mapToUIModel()
        return Image(name: name, contentMode: contentMode, appearance: appearance)
    }
}
