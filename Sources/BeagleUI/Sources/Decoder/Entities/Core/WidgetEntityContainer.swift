//
//  WidgetEntityContainer.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Used as a markup interface for the API representation of Widgets
public protocol WidgetEntity: Codable {}

/// Defines a container to hold a WidgetEntity dynamic types
struct WidgetEntityContainer: WidgetEntity {
    
    // MARK: - Aliases
    
    typealias Content = WidgetEntity & WidgetConvertible
    
    // MARK: - Properties
    
    let type: String
    let content: Content?
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        case type
        case content
    }
    
    // MARK: - Initialization/Decoding
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        if let decodeFunction = WidgetEntityContainer.decoders[type] {
            let rawContent = try decodeFunction(container)
            content = rawContent as? Content
        } else {
            content = nil
        }
    }
    
    init(type: String, content: Content? = nil) {
        self.type = type
        self.content = content
    }
    
    // MARK: - Encoding
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        
        if let content = self.content {
            guard let encode = WidgetEntityContainer.encoders[type] else {
                let context = EncodingError.Context(codingPath: [], debugDescription: "Invalid attachment: \(type).")
                throw EncodingError.invalidValue(self, context)
            }
            try encode(content, &container)
        } else {
            try container.encodeNil(forKey: .content)
        }
    }
    
    // MARK: - Registration
    
    private typealias WidgetContainerDecoder = (KeyedDecodingContainer<CodingKeys>) throws -> Any
    private typealias WidgetContainerEncoder = (WidgetEntity, inout KeyedEncodingContainer<CodingKeys>) throws -> Void
    
    private static var decoders: [String: WidgetContainerDecoder] = [:]
    private static var encoders: [String: WidgetContainerEncoder] = [:]
    
    /// Registers a type to be dynamicaly decoded
    ///
    /// - Parameters:
    ///   - type: the type to register, which needs to conform to Decodable
    ///   - typeName: the type's name, or the key it will be found at
    static func register<T: WidgetEntity>(_ type: T.Type, for typeName: String) {
        decoders[typeName] = { container in
            try container.decode(T.self, forKey: .content)
        }
        encoders[typeName] = { value, container in
            guard let typedValue = value as? T else {
                let typeName = String(describing: T.self)
                throw Error.cannotCastValueToType(typeName)
            }
            try container.encode(typedValue, forKey: .content)
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
