//
//  WidgetEntityContainer.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Used as a markup interface for the API representation of Widgets
public protocol WidgetEntity: Decodable {}

/// Combines both protocols in forder to add functionatily for the entities that are some type of content
public typealias WidgetConvertibleEntity = WidgetEntity & WidgetConvertible

/// Defines a container to hold a WidgetEntity dynamic types
struct WidgetEntityContainer: WidgetEntity {
    
    // MARK: - Properties
    
    let type: String
    let content: WidgetConvertibleEntity?
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        case type
        case content
    }
    
    // MARK: - Initialization/Decoding
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        let uppercasedType = type.uppercased()
        if let decodeFunction = WidgetEntityContainer.decoders[uppercasedType] {
            let rawContent = try decodeFunction(container)
            content = rawContent as? WidgetConvertibleEntity
        } else {
            content = nil
        }
    }
    
    init(type: String, content: WidgetConvertibleEntity? = nil) {
        self.type = type
        self.content = content
    }
    
    // MARK: - Registration
    
    private typealias WidgetContainerDecoder = (KeyedDecodingContainer<CodingKeys>) throws -> Any
    
    private static var decoders: [String: WidgetContainerDecoder] = [:]
    
    /// Registers a type to be dynamicaly decoded
    ///
    /// - Parameters:
    ///   - type: the type to register, which needs to conform to Decodable
    ///   - typeName: the type's name, or the key it will be found at
    static func register<T: WidgetEntity>(_ type: T.Type, for typeName: String) {
        let uppercasedType = typeName.uppercased()
        decoders[uppercasedType] = { container in
            try container.decode(T.self, forKey: .content)
        }
    }
    
}
extension WidgetEntityContainer {
    
    /// Defines an error specific for the `WidgetContainerEntity` context
    ///
    /// - cannotCastValueToType: the value could not be casted to an espcific type
    enum Error: Swift.Error {
        
        case cannotCastValueToType(String)
        
        var localizedDescription: String {
            switch self {
            case let .cannotCastValueToType(type):
                return "Could not cast value to \(type)"
            }
        }
        
    }
}
