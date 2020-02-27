//
//  Copyright © 13/02/20 Zup IT. All rights reserved.
//

import Foundation

public struct AccessibilityEntity: Decodable {
    public var accessibilityLabel: String?
    public var accessible: Bool?
}

extension AccessibilityEntity: UIModelConvertible {
    public func mapToUIModel() throws -> Accessibility {
        return Accessibility(
            accessibilityLabel: accessibilityLabel,
            accessible: accessible ?? true
        )
    }
}
