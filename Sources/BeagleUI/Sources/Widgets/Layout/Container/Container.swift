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
    
    init(
        header: Widget? = nil,
        content: Widget,
        footer: Widget? = nil
    ) {
        self.header = header
        self.content = content
        self.footer = footer
    }
    
    public init(
        header headerBuilder: (() -> Widget?)? = nil,
        content contentBuilder: () -> Widget,
        footer footerBuilder: (() -> Widget?)? = nil
    ) {
        let header = headerBuilder?()
        let content = contentBuilder()
        let footer = footerBuilder?()
        self.init(
            header: header,
            content: content,
            footer: footer
        )
    }
    
}
