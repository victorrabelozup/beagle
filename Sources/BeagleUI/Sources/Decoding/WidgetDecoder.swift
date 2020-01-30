//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

public protocol WidgetDecoding {
    func register<T: WidgetEntity>(_ type: T.Type, for typeName: String)
    func decodableType(forType type: String) -> Decodable.Type?
    func decodeWidget(from data: Data) throws -> Widget
    func decodeAction(from data: Data) throws -> Action
}

public protocol DependencyWidgetDecoding {
    var decoder: WidgetDecoding { get }
}

enum WidgetDecodingError: Error {
    case couldNotCastToType(String)
}

final class WidgetDecoder: WidgetDecoding {
    
    private enum ContentType: String {
        case widget
        case action
    }
    
    // MARK: - Dependencies
    
    private let jsonDecoder: JSONDecoder

    private let customNamespace: String

    private enum Namespace {
        case beagle
        case custom
    }

    private(set) var decoders: [String: Decodable.Type] = [:]
    
    // MARK: - Initialization
    
    init(
        jsonDecoder: JSONDecoder = JSONDecoder(),
        namespace: String = "custom"
    ) {
        self.jsonDecoder = jsonDecoder
        self.customNamespace = namespace

        registerDefaultTypes()
    }
    
    func register<T: WidgetEntity>(_ type: T.Type, for typeName: String) {
        let key = decodingKey(for: typeName, ofType: .widget, namespaceType: .custom)
        registerEntity(type, for: key)
    }
    
    func decodableType(forType type: String) -> Decodable.Type? {
        return decoders[type]
    }
    
    func decodeWidget(from data: Data) throws -> Widget {
        let entity: WidgetConvertibleEntity? = try decode(from: data)
        guard let widget = try entity?.mapToWidget() else {
            throw WidgetDecodingError.couldNotCastToType(String(describing: Widget.self))
        }
        return widget
    }
    
    func decodeAction(from data: Data) throws -> Action {
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
    
    private func decodingKey(
        for typeName: String,
        ofType contentType: ContentType,
        namespaceType: Namespace = .beagle
    ) -> String {
        let namespace = namespaceString(namespaceType)
        return "\(namespace):\(contentType.rawValue):\(typeName)".lowercased()
    }

    private func namespaceString(_ type: Namespace) -> String {
        switch type {
        case .beagle:
            return "beagle"
        case .custom:
            return customNamespace
        }
    }
    
    // MARK: - Types Registration
    
    private func registerDefaultTypes() {
        registerActions()
        registerCoreTypes()
        registerFormModels()
        registerLayoutTypes()
        registerUITypes()
    }
    
    private func registerActions() {
        registerEntity(NavigateEntity.self, for: decodingKey(for: "Navigate", ofType: .action))
        registerEntity(FormValidationEntity.self, for: decodingKey(for: "FormValidation", ofType: .action))
        registerEntity(ShowNativeDialogEntity.self, for: decodingKey(for: "ShowNativeDialog", ofType: .action))
        registerEntity(CustomActionEntity.self, for: decodingKey(for: "CustomAction", ofType: .action))
    }
    
    private func registerCoreTypes() {
        registerEntity(FlexWidgetEntity.self, for: decodingKey(for: "FlexWidget", ofType: .widget))
        registerEntity(FlexSingleWidgetEntity.self, for: decodingKey(for: "FlexSingleWidget", ofType: .widget))
        registerEntity(NavigatorEntity.self, for: decodingKey(for: "Navigator", ofType: .widget))
    }
    
    private func registerFormModels() {
        registerEntity(FormEntity.self, for: decodingKey(for: "Form", ofType: .widget))
        registerEntity(FormSubmitEntity.self, for: decodingKey(for: "FormSubmit", ofType: .widget))
        registerEntity(FormInputEntity.self, for: decodingKey(for: "FormInput", ofType: .widget))
    }
    
    private func registerLayoutTypes() {
        registerEntity(ScreenWidgetEntity.self, for: decodingKey(for: "ScreenWidget", ofType: .widget))
        registerEntity(SpacerEntity.self, for: decodingKey(for: "Spacer", ofType: .widget))
        registerEntity(ScrollViewEntity.self, for: decodingKey(for: "ScrollView", ofType: .widget))
    }
    
    private func registerUITypes() {
        registerEntity(ButtonEntity.self, for: decodingKey(for: "Button", ofType: .widget))
        registerEntity(ImageEntity.self, for: decodingKey(for: "Image", ofType: .widget))
        registerEntity(NetworkImageEntity.self, for: decodingKey(for: "NetworkImage", ofType: .widget))
        registerEntity(ListViewEntity.self, for: decodingKey(for: "ListView", ofType: .widget))
        registerEntity(TextEntity.self, for: decodingKey(for: "Text", ofType: .widget))
        registerEntity(PageViewEntity.self, for: decodingKey(for: "PageView", ofType: .widget))
        registerEntity(TabViewEntity.self, for: decodingKey(for: "TabView", ofType: .widget))
        registerEntity(DefaultPageIndicatorEntity.self, for: decodingKey(for: "DefaultPageIndicator", ofType: .widget))
        registerEntity(LazyWidgetEntity.self, for: decodingKey(for: "LazyWidget", ofType: .widget))
    }
        
    private func registerEntity<T: Decodable>(_ type: T.Type, for typeName: String) {
        decoders[typeName.lowercased()] = type
    }
}
