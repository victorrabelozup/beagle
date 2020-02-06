//
//  Copyright © 30/01/20 Zup IT. All rights reserved.
//

import Foundation

extension Navigate {
    struct PrefechableData {
        let path: String
    }

    var prefechableData: PrefechableData? {
        switch self {
        case .addView(let path), .swapView(let path), .presentView(let path):
            return PrefechableData(path: path)

        case .finishView, .popView, .popToView, .openDeepLink:
            return nil
        }
    }
}
