//
//  Copyright © 2019 Zup IT. All rights reserved.
//

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
            content = Unknown(type: type)
        }
    }
}

struct Unknown: ComponentConvertibleEntity {
    let type: String
    
    func mapToComponent() -> ServerDrivenComponent {
        return AnyComponent(value: self)
    }
}
