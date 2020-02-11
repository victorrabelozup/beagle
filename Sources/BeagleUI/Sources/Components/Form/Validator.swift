//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

public protocol Validator {
    func isValid(input: Any) -> Bool
}

public protocol ValidationErrorListener {
    func onValidationError(message: String?)
}
