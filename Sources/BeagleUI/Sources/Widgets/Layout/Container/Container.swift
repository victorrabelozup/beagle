//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct Container: Widget {

    // MARK: - Public Properties
    
    public let header: Widget?
    public let content: Widget
    public let footer: Widget?
    
    // MARK: - Initialization
    
    public init(
        header: Widget? = nil,
        content: Widget,
        footer: Widget? = nil
    ) {
        self.header = header
        self.content = content
        self.footer = footer
    }
}
