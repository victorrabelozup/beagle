//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct NetworkImageEntity: ComponentConvertibleEntity {
    let path: String
    let contentMode: ImageEntityContentMode?
    let appearance: AppearanceEntity?
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let contentMode = try self.contentMode?.mapToUIModel(ofType: ImageContentMode.self)
        let appearance = try self.appearance?.mapToUIModel()
        return NetworkImage(path: path, contentMode: contentMode, appearance: appearance)
    }
}
