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
    func decode(from data: Data) throws -> WidgetEntity?
    
    /// Decodes a container content to a given type
    ///
    /// - Parameters:
    ///   - type: the expected type
    ///   - data: the dat to decode
    /// - Returns: the widget entity refering the type
    /// - Throws: a decoding error, as in JSONDecoder
    func decodeContent<T: WidgetEntity>(ofType type: T.Type, from data: Data) throws -> T?
    
    /// Decodes a value, from some data, also enabling it's transformation to some 
    ///
    /// - Parameters:
    ///   - data: a data object from the API
    ///   - transformer: a value transformer
    /// - Returns: the transformed value
    /// - Throws: a decoding error, as in JSONDecoder
    func decode<T>(from data: Data, transformer: (WidgetEntity) throws -> T?) throws -> T?
}

public enum WidgetDecodingError: Error {
    case couldNotDecodeValueFromData
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
    /// - Returns: the widget entity
    /// - Throws: a decoding error, as in JSONDecoder
    func decode(from data: Data) throws -> WidgetEntity? {
        return try jsonDecoder.decode(WidgetEntityContainer.self, from: data).content
    }
    
    /// Decodes a container content to a given type
    ///
    /// - Parameters:
    ///   - type: the expected type
    ///   - data: the dat to decode
    /// - Returns: the widget entity refering the type
    /// - Throws: a decoding error, as in JSONDecoder
    func decodeContent<T: WidgetEntity>(ofType type: T.Type, from data: Data) throws -> T? {
        do {
            let widget = try jsonDecoder.decode(WidgetEntityContainer.self, from: data)
            return widget.content as? T
        } catch {
            throw error
        }
    }
    
    /// Decodes a value, from some data, also enabling it's transformation to some type
    /// that conforms with `WidgetEntity`
    ///
    /// - Parameters:
    ///   - data: a data object from the API
    ///   - transformer: a value transformer
    /// - Returns: the transformed value
    /// - Throws: a decoding error, as in JSONDecoder
    func decode<T>(from data: Data, transformer: (WidgetEntity) throws -> T?) throws -> T? {
        do {
            guard let value = try? decode(from: data) else {
                throw WidgetDecodingError.couldNotDecodeValueFromData
            }
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
    
    // MARK: - Types Registration
    
    private static func registerDefaultTypes() {
        registerCoreTypes()
        registerLayoutTypes()
        registerUITypes()
    }
    
    private static func registerCoreTypes() {
        registerContainerSubTypes()
        WidgetEntityContainer.register(FlexEntity.self, for: decodingKey(for: "flex"))
    }
    
    private static func registerContainerSubTypes() {
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "container"))
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "body"))
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "footer"))
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "content"))
        WidgetEntityContainer.register(WidgetEntityContainer.self, for: decodingKey(for: "children"))
    }
    
    private static func registerLayoutTypes() {
        WidgetEntityContainer.register(HorizontalEntity.self, for: decodingKey(for: "horizontal"))
        WidgetEntityContainer.register(PaddingEntity.self, for: decodingKey(for: "padding"))
        WidgetEntityContainer.register(SpacerEntity.self, for: decodingKey(for: "spacer"))
        WidgetEntityContainer.register(StackEntity.self, for: decodingKey(for: "stack"))
        WidgetEntityContainer.register(VerticalEntity.self, for: decodingKey(for: "vertical"))
    }
    
    private static func registerUITypes() {
        WidgetEntityContainer.register(ButtonEntity.self, for: decodingKey(for: "button"))
        WidgetEntityContainer.register(DropDownEntity.self, for: decodingKey(for: "dropdown"))
        WidgetEntityContainer.register(ImageEntity.self, for: decodingKey(for: "image"))
        WidgetEntityContainer.register(ListViewEntity.self, for: decodingKey(for: "listview"))
        WidgetEntityContainer.register(SelectViewEntity.self, for: decodingKey(for: "selectview"))
        WidgetEntityContainer.register(StyledWidgetEntity.self, for: decodingKey(for: "styledwidget"))
        WidgetEntityContainer.register(TextEntity.self, for: decodingKey(for: "text"))
        WidgetEntityContainer.register(TextFieldEntity.self, for: decodingKey(for: "textfield"))
        WidgetEntityContainer.register(ToolBarEntity.self, for: decodingKey(for: "toolbar"))
    }
    
}
