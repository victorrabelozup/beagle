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
    func decode(from data: Data) throws -> Action
}

enum WidgetDecodingError: Error {
    case couldNotCastToType(String)
}

final class WidgetDecoder: WidgetDecoding {
    
    // MARK: - Dependencies
    
    private let jsonDecoder: JSONDecoder
    private static let beagleNamespace = "beagle"
    private static var customWidgetsNamespace: String = beagleNamespace
    
    private static let widgetType = "widget"
    private static let actionType = "action"
    
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
        let decodingKey = WidgetDecoder.widgetDecodingKey(for: typeName, isCustom: true)
        AnyDecodableContainer.register(type, for: decodingKey)
    }
    
    func decode(from data: Data) throws -> Widget {
        let entity: WidgetConvertibleEntity? = try decode(from: data)
        guard let widget = try entity?.mapToWidget() else {
            throw WidgetDecodingError.couldNotCastToType(String(describing: Widget.self))
        }
        return widget
    }
    
    func decode(from data: Data) throws -> Action {
        let entity: ActionConvertibleEntity? = try decode(from: data)
        guard let action = try entity?.mapToAction() else {
            throw WidgetDecodingError.couldNotCastToType(String(describing: Action.self))
        }
        return action
    }
    
    // MARK: - Private Functions
        
    private func decode<T>(from data: Data) throws -> T {
        let container = try jsonDecoder.decode(AnyDecodableContainer.self, from: data)
        guard let content = container.content as? T else {
            throw WidgetDecodingError.couldNotCastToType(String(describing: T.self))
        }
        return content
    }

    private static func widgetDecodingKey(for typeName: String, isCustom: Bool = false) -> String {
        decodingKey(for: typeName, type: WidgetDecoder.widgetType, isCustom: isCustom)
    }
    
    private static func actionDecodingKey(for typeName: String) -> String {
        decodingKey(for: typeName, type: WidgetDecoder.actionType, isCustom: false)
    }
    
    private static func decodingKey(for typeName: String, type: String, isCustom: Bool = false) -> String {
        let namespace: String
        if isCustom && !customWidgetsNamespace.isEmpty {
            namespace = customWidgetsNamespace
        } else {
            namespace = beagleNamespace
        }
        return "\(namespace):\(type):\(typeName)".lowercased()
    }
    
    // MARK: - Types Registration
    
    private static func registerDefaultTypes() {
        registerActions()
        registerCoreTypes()
        registerFormModels()
        registerLayoutTypes()
        registerUITypes()
    }
    
    private static func registerActions() {
        AnyDecodableContainer.register(NavigateEntity.self, for: actionDecodingKey(for: "Navigate"))
        AnyDecodableContainer.register(FormValidationEntity.self, for: actionDecodingKey(for: "FormValidation"))
        AnyDecodableContainer.register(ShowNativeDialogEntity.self, for: actionDecodingKey(for: "ShowNativeDialog"))
        AnyDecodableContainer.register(CustomActionEntity.self, for: actionDecodingKey(for: "CustomAction"))
    }
    
    private static func registerFormModels() {
        AnyDecodableContainer.register(FormEntity.self, for: widgetDecodingKey(for: "Form"))
        AnyDecodableContainer.register(FormSubmitEntity.self, for: widgetDecodingKey(for: "FormSubmit"))
        AnyDecodableContainer.register(FormInputEntity.self, for: widgetDecodingKey(for: "FormInput"))
    }
    
    private static func registerCoreTypes() {
        AnyDecodableContainer.register(FlexWidgetEntity.self, for: widgetDecodingKey(for: "FlexWidget"))
        AnyDecodableContainer.register(FlexSingleWidgetEntity.self, for: widgetDecodingKey(for: "FlexSingleWidget"))
        AnyDecodableContainer.register(NavigatorEntity.self, for: widgetDecodingKey(for: "Navigator"))
    }
    
    private static func registerLayoutTypes() {
        AnyDecodableContainer.register(ContainerEntity.self, for: widgetDecodingKey(for: "Container"))
        AnyDecodableContainer.register(HorizontalEntity.self, for: widgetDecodingKey(for: "Horizontal"))
        AnyDecodableContainer.register(PaddingEntity.self, for: widgetDecodingKey(for: "Padding"))
        AnyDecodableContainer.register(SpacerEntity.self, for: widgetDecodingKey(for: "Spacer"))
        AnyDecodableContainer.register(StackEntity.self, for: widgetDecodingKey(for: "Stack"))
        AnyDecodableContainer.register(VerticalEntity.self, for: widgetDecodingKey(for: "Vertical"))
        AnyDecodableContainer.register(ScrollViewEntity.self, for: widgetDecodingKey(for: "ScrollView"))
    }
    
    private static func registerUITypes() {
        AnyDecodableContainer.register(ButtonEntity.self, for: widgetDecodingKey(for: "Button"))
        AnyDecodableContainer.register(ImageEntity.self, for: widgetDecodingKey(for: "Image"))
        AnyDecodableContainer.register(ListViewEntity.self, for: widgetDecodingKey(for: "ListView"))
        AnyDecodableContainer.register(TextEntity.self, for: widgetDecodingKey(for: "Text"))
        AnyDecodableContainer.register(NavigationBarEntity.self, for: widgetDecodingKey(for: "NavigationBar"))
    }
}
