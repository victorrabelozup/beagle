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
    
    private let jsonDecoder = JSONDecoder()

    private enum Namespace: String {
        case beagle
        case custom
    }

    private(set) var decoders: [String: Decodable.Type] = [:]
    
    // MARK: - Initialization
    
    init() {
        registerDefaultTypes()
    }
    
    func register<T: ComponentEntity>(_ type: T.Type, for typeName: String) {
        registerEntity(type, key: key(name: typeName, content: .component, namespace: .custom))
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
    
    private func key(
        name: String,
        content: ContentType,
        namespace: Namespace
    ) -> String {
        return "\(namespace):\(content.rawValue):\(name)".lowercased()
    }
    
    // MARK: - Default Types Registration
    
    private func registerDefaultTypes() {
        registerActions()
        registerCoreTypes()
        registerFormModels()
        registerLayoutTypes()
        registerUITypes()
    }
    
    private func registerActions() {
        registerEntity(NavigateEntity.self, key: key(name: "Navigate", content: .action, namespace: .beagle))
        registerEntity(FormValidationEntity.self, key: key(name: "FormValidation", content: .action, namespace: .beagle))
        registerEntity(ShowNativeDialogEntity.self, key: key(name: "ShowNativeDialog", content: .action, namespace: .beagle))
        registerEntity(CustomActionEntity.self, key: key(name: "CustomAction", content: .action, namespace: .beagle))
    }
    
    private func registerCoreTypes() {
        registerEntity(ContainerEntity.self, key: key(name: "Container", content: .component, namespace: .beagle))
        registerEntity(TouchableEntity.self, key: key(name: "Touchable", content: .component, namespace: .beagle))
    }
    
    private func registerFormModels() {
        registerEntity(FormEntity.self, key: key(name: "Form", content: .component, namespace: .beagle))
        registerEntity(FormSubmitEntity.self, key: key(name: "FormSubmit", content: .component, namespace: .beagle))
        registerEntity(FormInputEntity.self, key: key(name: "FormInput", content: .component, namespace: .beagle))
    }
    
    private func registerLayoutTypes() {
        registerEntity(ScreenComponentEntity.self, key: key(name: "ScreenComponent", content: .component, namespace: .beagle))
        registerEntity(SpacerEntity.self, key: key(name: "Spacer", content: .component, namespace: .beagle))
        registerEntity(ScrollViewEntity.self, key: key(name: "ScrollView", content: .component, namespace: .beagle))
    }
    
    private func registerUITypes() {
        registerEntity(ButtonEntity.self, key: key(name: "Button", content: .component, namespace: .beagle))
        registerEntity(ImageEntity.self, key: key(name: "Image", content: .component, namespace: .beagle))
        registerEntity(NetworkImageEntity.self, key: key(name: "NetworkImage", content: .component, namespace: .beagle))
        registerEntity(ListViewEntity.self, key: key(name: "ListView", content: .component, namespace: .beagle))
        registerEntity(TextEntity.self, key: key(name: "Text", content: .component, namespace: .beagle))
        registerEntity(PageViewEntity.self, key: key(name: "PageView", content: .component, namespace: .beagle))
        registerEntity(TabViewEntity.self, key: key(name: "TabView", content: .component, namespace: .beagle))
        registerEntity(DefaultPageIndicatorEntity.self, key: key(name: "PageIndicator", content: .component, namespace: .beagle))
        registerEntity(LazyComponentEntity.self, key: key(name: "LazyComponent", content: .component, namespace: .beagle))
    }
        
    private func registerEntity<T: Decodable>(_ type: T.Type, key: String) {
        decoders[key.lowercased()] = type
    }
}
