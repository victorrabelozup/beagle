//
//  Copyright © 30/12/19 Zup IT. All rights reserved.
//

import Foundation

struct AppearanceEntity: Decodable {
    let backgroundColor: String?
    let cornerRadius: Double?
}

extension AppearanceEntity: UIModelConvertible {
    func mapToUIModel() throws -> Appearance {
        return Appearance(backgroundColor: backgroundColor, cornerRadius: cornerRadius)
    }
}
