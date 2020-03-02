//
//  Copyright © 28/02/20 Zup IT. All rights reserved.
//

import UIKit

///This extension provide a method to apply accessibility identifiers to beagle components, for UITesting porpouses
extension UIView {
    public func applyAccessibilityIdentifier(_ id: String?) {
        if let accesibilityId = id {
            accessibilityIdentifier = accesibilityId
        }
    }
}
