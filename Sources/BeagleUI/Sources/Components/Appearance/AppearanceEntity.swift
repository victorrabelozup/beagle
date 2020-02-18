//
//  Copyright © 30/12/19 Zup IT. All rights reserved.
//

import Foundation

public struct AppearanceEntity: Decodable {
    let backgroundColor: String?
    let cornerRadius: CornerRadius?
}

extension AppearanceEntity: UIModelConvertible {
    func mapToUIModel() throws -> Appearance {
        return Appearance(backgroundColor: backgroundColor, cornerRadius: cornerRadius)
    }
}
