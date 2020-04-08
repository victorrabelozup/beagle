/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

/// Defines a container to hold any registered Decodable type
public struct AnyDecodableContainer {
    public let content: Decodable
}

// MARK: - Decodable
extension AnyDecodableContainer: Decodable {

    enum CodingKeys: String, CodingKey {
        case type = "_beagleType_"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        if let decodable = Beagle.dependencies.decoder.decodableType(forType: type.lowercased()) {
            content = try decodable.init(from: decoder)
        } else {
            Beagle.dependencies.logger.log(Log.decode(.decodingError(type: type)))
            content = UnknownComponent(type: type)
        }
    }
}

extension KeyedDecodingContainer {
    public func decode(forKey key: KeyedDecodingContainer<K>.Key) throws -> ServerDrivenComponent {
        let content = try decode(AnyDecodableContainer.self, forKey: key)
        return (content.content as? ServerDrivenComponent) ?? UnknownComponent(type: String(describing: content.content))
    }
    
    public func decode(forKey key: KeyedDecodingContainer<K>.Key) throws -> Action {
        let content = try decode(AnyDecodableContainer.self, forKey: key)
        return (content.content as? Action) ?? UnknownAction(type: String(describing: content.content))
    }
    
    public func decodeIfPresent(forKey key: KeyedDecodingContainer<K>.Key) throws -> ServerDrivenComponent? {
        let content = try decodeIfPresent(AnyDecodableContainer.self, forKey: key)
        return content?.content as? ServerDrivenComponent
    }
    
    public func decodeIfPresent(forKey key: KeyedDecodingContainer<K>.Key) throws -> Action? {
        let content = try decodeIfPresent(AnyDecodableContainer.self, forKey: key)
        return content?.content as? Action
    }
    
    public func decode(forKey key: KeyedDecodingContainer<K>.Key) throws -> [ServerDrivenComponent] {
        let content = try decode([AnyDecodableContainer].self, forKey: key)
        return content.map {
            ($0.content as? ServerDrivenComponent) ?? UnknownComponent(type: String(describing: $0.content))
        }
    }
}

struct UnknownComponent: ServerDrivenComponent {
    let type: String
}

extension UnknownComponent: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        #if DEBUG
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.text = "Unknown Component of type:\n \(String(describing: type))"
        label.textColor = .red
        label.backgroundColor = .yellow
        return label

        #else
        let view = UIView()
        return view

        #endif
    }
}
