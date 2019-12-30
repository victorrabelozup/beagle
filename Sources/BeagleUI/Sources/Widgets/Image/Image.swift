//
//  Copyright © 2019 Zup IT. All rights reserved.
//

public struct Image: Widget {
    
    // MARK: - Public Properties
    
    public let name: String
    public let contentMode: ImageContentMode?
    
    // MARK: - Initialization
    
    public init(
        name: String,
        contentMode: ImageContentMode? = nil
    ) {
        self.name = name
        self.contentMode = contentMode
    }
    
}
