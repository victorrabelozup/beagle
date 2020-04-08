/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

public enum ImageContentMode: String, Decodable {
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
