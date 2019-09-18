//
//  WidgetDecoder.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines a decoding strategy
protocol WidgetDecoding {
    
    /// Registers a type to be dynamicaly decoded
    ///
    /// - Parameters:
    ///   - type: the type to register, which needs to conform to Decodable
    ///   - typeName: the type's name, or the key it will be found at
    func register<T: Codable & WidgetEntity>(_ type: T.Type, for typeName: String)
    
    /// Decodes a type from a data object.
    ///
    /// - Parameter data: a data object
    /// - Returns: the widget entity refering the type
    /// - Throws: a decoding error, as in JSONDecoder
    func decode(from data: Data) throws -> WidgetEntity
}

final class WidgetDecoder: WidgetDecoding {
    
    // MARK: - Dependencies
    
    private let jsonDecoder: JSONDecoder
    private static var namespace: String = "beagle"
    
    // MARK: - Initialization
    
    init(jsonDecoder: JSONDecoder = JSONDecoder(), namespace: String = "beagle") {
        self.jsonDecoder = jsonDecoder
        WidgetDecoder.namespace = namespace
        WidgetDecoder.registerDefaultTypes()
    }
    
    // MARK: - Public Functions
    
    /// Registers a type to be dynamicaly decoded
    ///
    /// - Parameters:
    ///   - type: the type to register, which needs to conform to Decodable
    ///   - typeName: the type's name, or the key it will be found at
    func register<T: Codable & WidgetEntity>(_ type: T.Type, for typeName: String) {
        let decodingKey = WidgetDecoder.decodingKey(for: typeName)
        WidgetEntityContainer.register(type, for: decodingKey)
    }
    
    func decode(from data: Data) throws -> WidgetEntity {
        return try jsonDecoder.decode(WidgetEntityContainer.self, from: data)
    }
    
    // MARK: - Private Functions
    
    private static func registerDefaultTypes() {
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "container"))
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "body"))
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "footer"))
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "content"))
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "children"))
        WidgetEntityContainer.register(TextEntity.self, for: decodingKey(for: "text"))
    }
    
    private static func decodingKey(for typeName: String) -> String {
        let prefix = namespace.isEmpty ? "" : namespace + ":"
        return prefix + typeName.capitalizingFirstLetter()
    }
    
}
