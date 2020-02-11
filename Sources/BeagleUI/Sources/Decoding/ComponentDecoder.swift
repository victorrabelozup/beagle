//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

public protocol ComponentDecoding {
    typealias Error = ComponentDecodingError

    func register<T: ComponentEntity>(_ type: T.Type, for typeName: String)
    func decodableType(forType type: String) -> Decodable.Type?
    func decodeComponent(from data: Data) throws -> ServerDrivenComponent
    func decodeAction(from data: Data) throws -> Action
}

public protocol DependencyComponentDecoding {
    var decoder: ComponentDecoding { get }
}

public enum ComponentDecodingError: Error {
    case couldNotCastToType(String)
}

final class ComponentDecoder: ComponentDecoding {
    
    private enum ContentType: String {
        case component
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
    
    func register<T: ComponentEntity>(_ type: T.Type, for typeName: String) {
        let key = decodingKey(for: typeName, ofType: .component, namespaceType: .custom)
        registerEntity(type, for: key)
    }
    
    func decodableType(forType type: String) -> Decodable.Type? {
        return decoders[type]
    }
    
    func decodeComponent(from data: Data) throws -> ServerDrivenComponent {
        let entity: ComponentConvertibleEntity? = try decode(from: data)
        guard let component = try entity?.mapToComponent() else {
            throw ComponentDecodingError.couldNotCastToType(String(describing: ServerDrivenComponent.self))
        }
        return component
    }
    
    func decodeAction(from data: Data) throws -> Action {
        let entity: ActionConvertibleEntity? = try decode(from: data)
        guard let action = try entity?.mapToAction() else {
            throw ComponentDecodingError.couldNotCastToType(String(describing: Action.self))
        }
        return action
    }
    
    // MARK: - Private Functions
        
    private func decode<T>(from data: Data) throws -> T {
        let container = try jsonDecoder.decode(AnyDecodableContainer.self, from: data)
        guard let content = container.content as? T else {
            throw ComponentDecodingError.couldNotCastToType(String(describing: T.self))
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
        registerEntity(ContainerEntity.self, for: decodingKey(for: "Container", ofType: .component))
        registerEntity(TouchableEntity.self, for: decodingKey(for: "Touchable", ofType: .component))
    }
    
    private func registerFormModels() {
        registerEntity(FormEntity.self, for: decodingKey(for: "Form", ofType: .component))
        registerEntity(FormSubmitEntity.self, for: decodingKey(for: "FormSubmit", ofType: .component))
        registerEntity(FormInputEntity.self, for: decodingKey(for: "FormInput", ofType: .component))
    }
    
    private func registerLayoutTypes() {
        registerEntity(ScreenComponentEntity.self, for: decodingKey(for: "ScreenComponent", ofType: .component))
        registerEntity(SpacerEntity.self, for: decodingKey(for: "Spacer", ofType: .component))
        registerEntity(ScrollViewEntity.self, for: decodingKey(for: "ScrollView", ofType: .component))
    }
    
    private func registerUITypes() {
        registerEntity(ButtonEntity.self, for: decodingKey(for: "Button", ofType: .component))
        registerEntity(ImageEntity.self, for: decodingKey(for: "Image", ofType: .component))
        registerEntity(NetworkImageEntity.self, for: decodingKey(for: "NetworkImage", ofType: .component))
        registerEntity(ListViewEntity.self, for: decodingKey(for: "ListView", ofType: .component))
        registerEntity(TextEntity.self, for: decodingKey(for: "Text", ofType: .component))
        registerEntity(PageViewEntity.self, for: decodingKey(for: "PageView", ofType: .component))
        registerEntity(TabViewEntity.self, for: decodingKey(for: "TabView", ofType: .component))
        registerEntity(DefaultPageIndicatorEntity.self, for: decodingKey(for: "DefaultPageIndicator", ofType: .component))
        registerEntity(LazyComponentEntity.self, for: decodingKey(for: "LazyComponent", ofType: .component))
    }
        
    private func registerEntity<T: Decodable>(_ type: T.Type, for typeName: String) {
        decoders[typeName.lowercased()] = type
    }
}
