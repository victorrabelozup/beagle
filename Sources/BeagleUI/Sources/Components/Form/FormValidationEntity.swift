//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

struct FieldErrorEntity: Decodable {
    let inputName: String
    let message: String
}

extension FieldErrorEntity: UIModelConvertible {
    func mapToUIModel() throws -> FieldError {
        return FieldError(inputName: inputName, message: message)
    }
}

struct FormValidationEntity: Decodable {
    let errors: [FieldErrorEntity]
}

extension FormValidationEntity: ActionConvertibleEntity {
    func mapToAction() throws -> Action {
        let errors = try self.errors.compactMap {
            try $0.mapToUIModel()
        }
        return FormValidation(errors: errors)
    }
}
