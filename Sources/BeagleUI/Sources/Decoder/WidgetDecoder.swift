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
    case couldNotDecodeContentForEntityOnKey(String, String)
}

public final class WidgetDecoder: WidgetDecoding {
    
    // MARK: - Dependencies
    
    private let jsonDecoder: JSONDecoder
    private let dataPreprocessor: DataPreprocessor
    private static var namespace: String = "beagle"
    
    // MARK: - Initialization
    
    init(
        jsonDecoder: JSONDecoder = JSONDecoder(),
        dataPreprocessor: DataPreprocessor = DataPreprocessing(),
        namespace: String = "beagle"
    ) {
        self.jsonDecoder = jsonDecoder
        self.dataPreprocessor = dataPreprocessor
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
        let normalizedData = try dataPreprocessor.normalizeData(data, for: WidgetDecoder.namespace)
        return try jsonDecoder.decode(WidgetEntityContainer.self, from: normalizedData)
    }
    
    /// Decodes a type from a data object, needs to be casted to the root type.
    ///
    /// - Parameter data: a data object from the API
    /// - Returns: the widget entity
    /// - Throws: a decoding error, as in JSONDecoder
    func decode(from data: Data) throws -> WidgetEntity? {
        let normalizedData = try dataPreprocessor.normalizeData(data, for: WidgetDecoder.namespace)
        do {
            let container = try jsonDecoder.decode(WidgetEntityContainer.self, from: normalizedData)
            return container.content
        } catch {
            debugPrint(error)
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
        WidgetEntityContainer.register(FlexEntity.self, for: decodingKey(for: "Flex"))
    }
    
    private static func registerLayoutTypes() {
        WidgetEntityContainer.register(HorizontalEntity.self, for: decodingKey(for: "Horizontal"))
        WidgetEntityContainer.register(PaddingEntity.self, for: decodingKey(for: "Padding"))
        WidgetEntityContainer.register(SpacerEntity.self, for: decodingKey(for: "Spacer"))
        WidgetEntityContainer.register(StackEntity.self, for: decodingKey(for: "Stack"))
        WidgetEntityContainer.register(VerticalEntity.self, for: decodingKey(for: "Vertical"))
    }
    
    private static func registerUITypes() {
        WidgetEntityContainer.register(ButtonEntity.self, for: decodingKey(for: "Button"))
        WidgetEntityContainer.register(DropDownEntity.self, for: decodingKey(for: "Dropdown"))
        WidgetEntityContainer.register(ImageEntity.self, for: decodingKey(for: "Image"))
        WidgetEntityContainer.register(ListViewEntity.self, for: decodingKey(for: "ListView"))
        WidgetEntityContainer.register(SelectViewEntity.self, for: decodingKey(for: "SelectView"))
        WidgetEntityContainer.register(StyledWidgetEntity.self, for: decodingKey(for: "StyledWidget"))
        WidgetEntityContainer.register(TextEntity.self, for: decodingKey(for: "Text"))
        WidgetEntityContainer.register(TextFieldEntity.self, for: decodingKey(for: "TextField"))
        WidgetEntityContainer.register(ToolBarEntity.self, for: decodingKey(for: "ToolBar"))
    }
    
}
