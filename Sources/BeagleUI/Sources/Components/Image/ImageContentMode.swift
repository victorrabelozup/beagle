//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public enum ImageContentMode: String, StringRawRepresentable {
    case fitXY = "FIT_XY" // scaleToFill
    case fitCenter = "FIT_CENTER" // scaleAspectFit
    case centerCrop = "CENTER_CROP" // scaleAspectFill
    case center = "CENTER" // center
}
extension ImageContentMode {
    func toUIKit() -> UIImageView.ContentMode {
        switch self {
        case .fitXY:
            return .scaleToFill
        case .fitCenter:
            return .scaleAspectFit
        case .centerCrop:
            return .scaleAspectFill
        case .center:
            return .center
        }
    }
}
