//
//  UIModelConvertible.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines UIModel conversion errors
///
/// - invalidRawValueTypeForEnum: states that the UIModel Enum does not has a RawValue == String
enum UIModelConversionError: Error {
    case invalidRawValueTypeForEnum(String)
    
    var localizedDescription: String {
        switch self {
        case let .invalidRawValueTypeForEnum(type):
            return "The UIModel Enum does not has a RawValue == String on \(type). Check that."
        }
    }
}

/// Defines a protocol to constrain raw representables where the RawValue is a String
protocol StringRawRepresentable: RawRepresentable where RawValue == String {}

/// Markup to define that this type can be converted to a UIModel Enum
protocol UIEnumModelConvertible: RawRepresentable {
    func mapToUIModel<T>(ofType: T.Type) throws -> T where T: StringRawRepresentable
}
extension UIEnumModelConvertible {
    func mapToUIModel<T>(ofType: T.Type) throws -> T where T: StringRawRepresentable {
        guard let rawValue = self.rawValue as? String,
            let uiModel = T(rawValue: rawValue) else {
                let type = String(describing: self)
                throw UIModelConversionError.invalidRawValueTypeForEnum(type)
        }
        return uiModel
    }
}

/// Markup to define that this type can be converted to a UIModel
protocol UIModelConvertible {
    
    associatedtype UIModelType
    
    /// Maps something to a UIModel
    ///
    /// - Returns: an UIModel
    /// - Throws: a UIModelParsing error
    func mapToUIModel() throws -> UIModelType
}
