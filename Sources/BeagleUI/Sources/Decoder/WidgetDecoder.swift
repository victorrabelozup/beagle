//
//  WidgetDecoder.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines a decoding strategy
public protocol WidgetDecoding {
    
    /// Registers a type to be dynamicaly decoded
    ///
    /// - Parameters:
    ///   - type: the type to register, which needs to conform to Decodable
    ///   - typeName: the type's name, or the key it will be found at
    static func register<T: Codable>(_ type: T.Type, for typeName: String)
    
    /// Decodes a type from a data object.
    ///
    /// - Parameter data: a data object
    /// - Returns: the widget entity refering the type
    /// - Throws: a decoding error, as in JSONDecoder
    func decode(from data: Data) throws -> WidgetEntity
}

final public class WidgetDecoder: WidgetDecoding {
    
    // MARK: - Dependencies
    
    private let jsonDecoder: JSONDecoder
    
    // MARK: - Initialization
    
    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
        WidgetDecoder.registerTypes()
    }
    
    // MARK: - Public Functions
    
    /// Registers a type to be dynamicaly decoded
    ///
    /// - Parameters:
    ///   - type: the type to register, which needs to conform to Decodable
    ///   - typeName: the type's name, or the key it will be found at
    static func registerCustomType<T: Codable>(_ type: T.Type, with name: String) {
        WidgetEntityContainer.register(type, for: typeName)
    }
    
    func decode(from data: Data) -> WidgetEntity {
        return try jsonDecoder.decode(WidgetEntityContainer, from: data)
    }
    
    // MARK: - Private Functions
    
    private static func registerDefaultTypes() {
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: "container")
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: "body")
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: "footer")
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: "content")
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: "children")
        WidgetEntityContainer.register(TextEntity.self, for: "text")
    }
    
}
