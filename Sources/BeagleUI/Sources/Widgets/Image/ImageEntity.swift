//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct ImageEntity: WidgetConvertibleEntity {
    let name: String
    let contentMode: ImageEntityContentMode?
    
    func mapToWidget() throws -> Widget {
        let contentMode = try self.contentMode?.mapToUIModel(ofType: ImageContentMode.self)
        return Image(name: name, contentMode: contentMode)
    }
}
