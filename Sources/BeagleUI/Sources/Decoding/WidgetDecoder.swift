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
    
    /// Decodes a top-level value of the given type from the given JSON representation.
    ///
    /// - parameter type: The type of the value to decode.
    /// - parameter data: The data to decode from.
    /// - returns: A value of the requested type.
    /// - throws: `DecodingError.dataCorrupted` if values requested from the payload are corrupted, or if the given data is not valid JSON.
    /// - throws: An error if any value throws an error during decoding.
    func decodeToWidget<T>(ofType type: T.Type, from data: Data) throws -> T where T: Widget
    
    /// Decodes a value, from some data, also enabling it's transformation to some type
    /// that conforms with `Widget`
    ///
    /// - Parameters:
    ///   - data: a data object from the API
    ///   - transformer: a value transformer
    /// - Returns: the transformed value
    /// - Throws: a decoding error, as in JSONDecoder
    func decode<T>(from data: Data, transformer: (Widget) throws -> T?) throws -> T?
}

enum WidgetDecodingError: Error {
    case couldNotDecodeContentForEntityOnKey(String, String)
    case couldNotCastToType(String)
}

final class WidgetDecoder: WidgetDecoding {
    
    // MARK: - Dependencies
    
    private let jsonDecoder: JSONDecoder
    private let dataPreprocessor: DataPreprocessor
    private static let beagleNamespace = "beagle"
    private static var customWidgetsNamespace: String = beagleNamespace
    private var namespaces: [String] = [WidgetDecoder.beagleNamespace]
    
    // MARK: - Initialization
    
    init(
        jsonDecoder: JSONDecoder = JSONDecoder(),
        dataPreprocessor: DataPreprocessor = DataPreprocessing(),
        namespace: String = "beagle"
    ) {
        self.jsonDecoder = jsonDecoder
        self.dataPreprocessor = dataPreprocessor
        setupCustomNamespace(namespace)
        WidgetDecoder.registerDefaultTypes()
    }
    
    // MARK: - Public Functions
    
    /// Registers a type to be dynamicaly decoded
    ///
    /// - Parameters:
    ///   - type: the type to register, which needs to conform to Decodable
    ///   - typeName: the type's name, or the key it will be found at
    func register<T: WidgetEntity>(_ type: T.Type, for typeName: String) {
        let decodingKey = WidgetDecoder.decodingKey(for: typeName, isCustom: true)
        WidgetEntityContainer.register(type, for: decodingKey)
    }
    
    /// Decodes a type from a data object, needs to be casted to the root type.
    ///
    /// - Parameter data: a data object from the API
    /// - Returns: the widget entity
    /// - Throws: a decoding error, as in JSONDecoder
    func decode(from data: Data) throws -> WidgetEntity? {
        let container = try decodeContainer(from: data)
        return container?.content
    }
    
    /// Decodes a top-level value of the given type from the given JSON representation.
    ///
    /// - parameter type: The type of the value to decode.
    /// - parameter data: The data to decode from.
    /// - returns: A value of the requested type.
    /// - throws: `DecodingError.dataCorrupted` if values requested from the payload are corrupted, or if the given data is not valid JSON.
    /// - throws: An error if any value throws an error during decoding.
    func decodeToWidget<T>(ofType type: T.Type, from data: Data) throws -> T where T: Widget {
        guard let widget = try decode(from: data, transformer: { $0 as? T }) else {
            let typeString = String(describing: type)
            throw WidgetDecodingError.couldNotCastToType(typeString)
        }
        return widget
    }
    
    /// Decodes a value, from some data, also enabling it's transformation to some type
    /// that conforms with `Widget`
    ///
    /// - Parameters:
    ///   - data: a data object from the API
    ///   - transformer: a value transformer
    /// - Returns: the transformed value
    /// - Throws: a decoding error, as in JSONDecoder
    func decode<T>(from data: Data, transformer: (Widget) throws -> T?) throws -> T? {
        let container = try decodeContainer(from: data)
        guard let uiModel = try container?.content?.mapToWidget() else {
            return nil
        }
        return try transformer(uiModel)
    }
    
    // MARK: - Private Functions
    
    private func setupCustomNamespace(_ customNamespace: String) {
        WidgetDecoder.customWidgetsNamespace = customNamespace
        if WidgetDecoder.beagleNamespace != customNamespace {
            namespaces = [WidgetDecoder.beagleNamespace, customNamespace]
        }
    }
    
    private func decodeContainer(from data: Data) throws -> WidgetEntityContainer? {
        let normalizedData = try dataPreprocessor.normalizeData(data, for: namespaces)
        return try jsonDecoder.decode(WidgetEntityContainer.self, from: normalizedData)
    }

    // MARK: - Private Helpers
    
    private static func decodingKey(for typeName: String, isCustom: Bool = false) -> String {
        var prefix = beagleNamespace + ":widget:"
        if isCustom && !customWidgetsNamespace.isEmpty {
            prefix = customWidgetsNamespace + ":widget:"
        }
        return prefix.lowercased() + typeName.lowercased()
    }
    
    // MARK: - Types Registration
    
    private static func registerDefaultTypes() {
        registerCoreTypes()
        registerFormModels()
        registerLayoutTypes()
        registerUITypes()
    }
    
    private static func registerFormModels() {
        WidgetEntityContainer.register(FormEntity.self, for: decodingKey(for: "Form"))
        WidgetEntityContainer.register(FormSubmitEntity.self, for: decodingKey(for: "FormSubmit"))
        WidgetEntityContainer.register(FormInputEntity.self, for: decodingKey(for: "FormInput"))
    }
    
    private static func registerCoreTypes() {
        WidgetEntityContainer.register(FlexWidgetEntity.self, for: decodingKey(for: "FlexWidget"))
        WidgetEntityContainer.register(FlexSingleWidgetEntity.self, for: decodingKey(for: "FlexSingleWidget"))
        WidgetEntityContainer.register(NavigatorEntity.self, for: decodingKey(for: "Navigator"))
    }
    
    private static func registerLayoutTypes() {
        WidgetEntityContainer.register(ContainerEntity.self, for: decodingKey(for: "Container"))
        WidgetEntityContainer.register(HorizontalEntity.self, for: decodingKey(for: "Horizontal"))
        WidgetEntityContainer.register(PaddingEntity.self, for: decodingKey(for: "Padding"))
        WidgetEntityContainer.register(SpacerEntity.self, for: decodingKey(for: "Spacer"))
        WidgetEntityContainer.register(StackEntity.self, for: decodingKey(for: "Stack"))
        WidgetEntityContainer.register(VerticalEntity.self, for: decodingKey(for: "Vertical"))
        WidgetEntityContainer.register(ScrollViewEntity.self, for: decodingKey(for: "ScrollView"))
    }
    
    private static func registerUITypes() {
        WidgetEntityContainer.register(ButtonEntity.self, for: decodingKey(for: "Button"))
        WidgetEntityContainer.register(ImageEntity.self, for: decodingKey(for: "Image"))
        WidgetEntityContainer.register(ListViewEntity.self, for: decodingKey(for: "ListView"))
        WidgetEntityContainer.register(TextEntity.self, for: decodingKey(for: "Text"))
    }
    
}
