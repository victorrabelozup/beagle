//
//  AnyDecodableContainer.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

/// Defines a container to hold any registered Decodable type
struct AnyDecodableContainer {
    let content: Decodable
}

// MARK: - Registration
extension AnyDecodableContainer {
    static var decoders: [String: (SingleValueDecodingContainer) throws -> Decodable] = [:]
    
    static func register<T: Decodable>(_ type: T.Type, for typeName: String) {
        decoders[typeName.lowercased()] = { container in
            try container.decode(T.self)
        }
    }
}

// MARK: - Decodable
extension AnyDecodableContainer: Decodable {
    enum CodingKeys: String, CodingKey {
        case type = "_beagleType_"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        let singleValueContainer = try decoder.singleValueContainer()
        if let decoder = AnyDecodableContainer.decoders[type] {
            content = try decoder(singleValueContainer)
        } else {
            content = Unknown(type: type)
        }
    }
}

struct Unknown: WidgetConvertibleEntity {
    let type: String
    
    func mapToWidget() -> Widget {
        return AnyWidget(value: self)
    }
}
