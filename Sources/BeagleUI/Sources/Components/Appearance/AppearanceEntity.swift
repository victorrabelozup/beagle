//
//  Copyright © 30/12/19 Zup IT. All rights reserved.
//

import Foundation

public struct AppearanceEntity: Decodable {
    public let backgroundColor: String?
    public let cornerRadius: CornerRadius?
}

extension AppearanceEntity: UIModelConvertible {
    public func mapToUIModel() throws -> Appearance {
        return Appearance(backgroundColor: backgroundColor, cornerRadius: cornerRadius)
    }
}
