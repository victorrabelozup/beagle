//
//  WidgetDecoder.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

protocol WidgetDecoding {
    func register<T: WidgetEntity>(_ type: T.Type, for typeName: String)
    func decode(from data: Data) throws -> Widget
}

enum WidgetDecodingError: Error {
    case couldNotCastToType(String)
}

final class WidgetDecoder: WidgetDecoding {
    
    // MARK: - Dependencies
    
    private let jsonDecoder: JSONDecoder
    private static let beagleNamespace = "beagle"
    private static var customWidgetsNamespace: String = beagleNamespace
    
    // MARK: - Initialization
    
    init(
        jsonDecoder: JSONDecoder = JSONDecoder(),
        namespace: String = "beagle"
    ) {
        self.jsonDecoder = jsonDecoder
        WidgetDecoder.customWidgetsNamespace = namespace
        WidgetDecoder.registerDefaultTypes()
    }
    
    func register<T: WidgetEntity>(_ type: T.Type, for typeName: String) {
        let decodingKey = WidgetDecoder.decodingKey(for: typeName, isCustom: true)
        AnyDecodableContainer.register(type, for: decodingKey)
    }
    
    func decode(from data: Data) throws -> Widget {
        let entity: WidgetEntity? = try decode(from: data)
        let convertible = entity as? WidgetConvertibleEntity
        guard let widget = try convertible?.mapToWidget() else {
            throw WidgetDecodingError.couldNotCastToType(String(describing: Widget.self))
        }
        return widget
    }
        
    // MARK: - Private Functions
    
    private func decode(from data: Data) throws -> WidgetEntity {
        let container = try jsonDecoder.decode(AnyDecodableContainer.self, from: data)
        guard let content = container.content as? WidgetConvertibleEntity else {
            throw WidgetDecodingError.couldNotCastToType(String(describing: WidgetConvertibleEntity.self))
        }
        return content
    }

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
        AnyDecodableContainer.register(FormEntity.self, for: decodingKey(for: "Form"))
        AnyDecodableContainer.register(FormSubmitEntity.self, for: decodingKey(for: "FormSubmit"))
        AnyDecodableContainer.register(FormInputEntity.self, for: decodingKey(for: "FormInput"))
    }
    
    private static func registerCoreTypes() {
        AnyDecodableContainer.register(FlexWidgetEntity.self, for: decodingKey(for: "FlexWidget"))
        AnyDecodableContainer.register(FlexSingleWidgetEntity.self, for: decodingKey(for: "FlexSingleWidget"))
        AnyDecodableContainer.register(NavigatorEntity.self, for: decodingKey(for: "Navigator"))
    }
    
    private static func registerLayoutTypes() {
        AnyDecodableContainer.register(ContainerEntity.self, for: decodingKey(for: "Container"))
        AnyDecodableContainer.register(HorizontalEntity.self, for: decodingKey(for: "Horizontal"))
        AnyDecodableContainer.register(PaddingEntity.self, for: decodingKey(for: "Padding"))
        AnyDecodableContainer.register(SpacerEntity.self, for: decodingKey(for: "Spacer"))
        AnyDecodableContainer.register(StackEntity.self, for: decodingKey(for: "Stack"))
        AnyDecodableContainer.register(VerticalEntity.self, for: decodingKey(for: "Vertical"))
        AnyDecodableContainer.register(ScrollViewEntity.self, for: decodingKey(for: "ScrollView"))
    }
    
    private static func registerUITypes() {
        AnyDecodableContainer.register(ButtonEntity.self, for: decodingKey(for: "Button"))
        AnyDecodableContainer.register(ImageEntity.self, for: decodingKey(for: "Image"))
        AnyDecodableContainer.register(ListViewEntity.self, for: decodingKey(for: "ListView"))
        AnyDecodableContainer.register(TextEntity.self, for: decodingKey(for: "Text"))
        AnyDecodableContainer.register(NavigationBarEntity.self, for: decodingKey(for: "NavigationBar"))
    }
}
