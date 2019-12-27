//
//  Copyright © 21/11/19 Zup IT. All rights reserved.
//

import Foundation
import UIKit

public struct PageView: Widget {

    public let pages: [Widget]
    public let pageIndicator: PageIndicator?

    public init(
        pages: [Widget],
        pageIndicator: PageIndicator?
    ) {
        self.pages = pages
        self.pageIndicator = pageIndicator
    }
}

public protocol PageIndicator: Widget {}
