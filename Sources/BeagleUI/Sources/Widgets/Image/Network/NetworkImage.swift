//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

public struct NetworkImage: Widget {
    
    public let url: String
    public let contentMode: ImageContentMode?
    
    // MARK: - Initialization
    
    public init(
        url: String,
        contentMode: ImageContentMode? = nil
    ) {
        self.url = url
        self.contentMode = contentMode
    }
    
}
