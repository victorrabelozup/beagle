//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

public struct NetworkImage: Widget, HasAppearance {
    
    public let url: String
    public let contentMode: ImageContentMode?
    public let appearance: Appearance?
    
    // MARK: - Initialization
    
    public init(
        url: String,
        contentMode: ImageContentMode? = nil,
        appearance: Appearance? = nil
    ) {
        self.url = url
        self.contentMode = contentMode
        self.appearance = appearance
    }
    
}
