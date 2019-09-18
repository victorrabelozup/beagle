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
    func register<T: WidgetEntity>(_ type: T.Type, for typeName: String)
    
    /// Decodes a type from a data object, needs to be casted to the root type.
    ///
    /// - Parameter data: a data object
    /// - Returns: the widget entity refering the type
    /// - Throws: a decoding error, as in JSONDecoder
    func decode<T: WidgetEntity>(from data: Data) throws -> T
    
    /// Decodes a value, from some data, also enabling it's transformation to some type
    /// that conforms with `WidgetEntity`
    ///
    /// - Parameters:
    ///   - data: a data object from the API
    ///   - transformer: a value transformer
    /// - Returns: the transformed value
    /// - Throws: a decoding error, as in JSONDecoder
    func decode<T: WidgetEntity>(from data: Data, transformer: (WidgetEntity) throws -> T?) throws -> T?
}

public final class WidgetDecoder: WidgetDecoding {
    
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
    func register<T: WidgetEntity>(_ type: T.Type, for typeName: String) {
        let decodingKey = WidgetDecoder.decodingKey(for: typeName)
        WidgetEntityContainer.register(type, for: decodingKey)
    }
    
    
    /// Decodes some date to a WidgetEntityContainer
    ///
    /// - Parameter data: a data object from the API
    /// - Returns: a WidgetEntityContainer from it's data
    /// - Throws:  a decoding error, as in JSONDecoder
    func decodeToContainer(from data: Data) throws -> WidgetEntityContainer {
        return try jsonDecoder.decode(WidgetEntityContainer.self, from: data)
    }
    
    /// Decodes a type from a data object, needs to be casted to the root type.
    ///
    /// - Parameter data: a data object from the API
    /// - Returns: the widget entity refering the type
    /// - Throws: a decoding error, as in JSONDecoder
    func decode<T: WidgetEntity>(from data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    /// Decodes a value, from some data, also enabling it's transformation to some type
    /// that conforms with `WidgetEntity`
    ///
    /// - Parameters:
    ///   - data: a data object from the API
    ///   - transformer: a value transformer
    /// - Returns: the transformed value
    /// - Throws: a decoding error, as in JSONDecoder
    func decode<T: WidgetEntity>(from data: Data, transformer: (WidgetEntity) throws -> T?) throws -> T? {
        do {
            let value = try jsonDecoder.decode(T.self, from: data)
            return try transformer(value)
        } catch {
            throw error
        }
    }
    
    // MARK: - Private Helpers
    
    private static func decodingKey(for typeName: String) -> String {
        let prefix = namespace.isEmpty ? "" : namespace + ":"
        return prefix + typeName.capitalizingFirstLetter()
    }
    
    private static func registerDefaultTypes() {
        registerCoreTypes()
        WidgetEntityContainer.register(TextEntity.self, for: decodingKey(for: "text"))
    }
    
    // MARK: - Core Types Registration
    private static func registerCoreTypes() {
        registerContainerSubTypes()
    }
    
    private static func registerContainerSubTypes() {
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "container"))
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "body"))
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "footer"))
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "content"))
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "children"))
    }
    
    private static func registerFlexTypes() {
        WidgetEntityContainer.register(FlexEntity.self, for: decodingKey(for: "container"))
    }
    
}
