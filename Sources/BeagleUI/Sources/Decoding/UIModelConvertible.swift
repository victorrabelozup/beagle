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
/// - rawValueIsNotOfStringForType: states that the Entity Enum does not has a RawValue == String
enum UIModelConversionError: Error {
    
    case couldNotInitializeEnumOfType(String)
    case rawValueIsNotOfStringForType(String)
    
    var localizedDescription: String {
        switch self {
        case let .couldNotInitializeEnumOfType(type):
            return "The UIModel could not be initialized for \(type), check it's entity cases."
        case let .rawValueIsNotOfStringForType(type):
            return "The Entity Enum does not has a RawValue == String on \(type). Check that."
        }
    }
}

/// Defines a protocol to constrain raw representables where the RawValue is a String
public protocol StringRawRepresentable: RawRepresentable where RawValue == String {}

/// Markup to define that this type can be converted to a UIModel Enum
public protocol UIEnumModelConvertible: RawRepresentable {
    func mapToUIModel<T>(ofType: T.Type) throws -> T where T: StringRawRepresentable
}
extension UIEnumModelConvertible {
    public func mapToUIModel<T>(ofType: T.Type) throws -> T where T: StringRawRepresentable {
        guard let rawValue = self.rawValue as? String else {
            let type = String(describing: self)
            throw UIModelConversionError.rawValueIsNotOfStringForType(type)
        }
        guard let uiModel = T(rawValue: rawValue) else {
            let type = String(describing: T.self)
            throw UIModelConversionError.couldNotInitializeEnumOfType(type)
        }
        return uiModel
    }
}

/// Markup to define that this type can be converted to a UIModel
public protocol UIModelConvertible {
    
    associatedtype UIModelType
    
    /// Maps something to a UIModel
    ///
    /// - Returns: an UIModel
    /// - Throws: a UIModelParsing error
    func mapToUIModel() throws -> UIModelType
}
