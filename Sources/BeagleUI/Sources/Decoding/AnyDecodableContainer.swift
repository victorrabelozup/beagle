//
//  Copyright © 2019 Zup IT. All rights reserved.
//

/// Defines a container to hold any registered Decodable type
struct AnyDecodableContainer {
    let content: Decodable
}

// MARK: - Decodable
extension AnyDecodableContainer: Decodable {

    enum CodingKeys: String, CodingKey {
        case type = "_beagleType_"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        if let decodable = Beagle.dependencies.decoder.decodableType(forType: type.lowercased()) {
            content = try decodable.init(from: decoder)
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
