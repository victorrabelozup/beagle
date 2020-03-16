//
//  Copyright © 29/01/20 Zup IT. All rights reserved.
//

import UIKit

public extension UIView {
    var allSubviews: [UIView] {
        return self.subviews.reduce([UIView]()) { $0 + [$1] + $1.allSubviews }
    }
}
