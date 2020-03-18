//
//  Copyright © 04/12/19 Zup IT. All rights reserved.
//

import Foundation
import UIKit

public struct PageIndicatorUIViewModel {
    public let numberOfPages: Int
    public let currentPage: Int
}

public protocol PageIndicatorUIView: AnyObject {
    var outputReceiver: PageIndicatorOutput? { get set }
    var model: PageIndicatorUIViewModel? { get set }
}

public protocol PageIndicatorOutput: AnyObject {
    func swipeToPage(at index: Int)
}
