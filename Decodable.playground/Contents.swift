import Foundation

public protocol Widget {}

struct WidgetContainer: Widget, Codable {
    
    let type: String
    let content: Widget?
    
    private enum CodingKeys: String, CodingKey {
        case type
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        if let decodeFunction = WidgetContainer.decoders[type] {
            let rawContent = try decodeFunction(container)
            content = rawContent as? Widget
        } else if let container = try? decoder.singleValueContainer().decode(WidgetContainer.self) {
            content = container
        } else {
            content = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        
        if let content = self.content {
            guard let encode = WidgetContainer.encoders[type] else {
                let context = EncodingError.Context(codingPath: [], debugDescription: "Invalid attachment: \(type).")
                throw EncodingError.invalidValue(self, context)
            }
            try encode(content, &container)
        } else {
            try container.encodeNil(forKey: .content)
        }
    }
    
    // MARK: Registration
    
    private typealias WidgetContainerDecoder = (KeyedDecodingContainer<CodingKeys>) throws -> Any
    private typealias WidgetContainerEncoder = (Widget, inout KeyedEncodingContainer<CodingKeys>) throws -> Void
    
    private static var decoders: [String: WidgetContainerDecoder] = [:]
    private static var encoders: [String: WidgetContainerEncoder] = [:]
    
    static func register<T: Codable>(_ type: T.Type, for typeName: String) {
        decoders[typeName] = { container in
            
            return try container.decode(T.self, forKey: .content)
        }
        encoders[typeName] = { value, container in
            guard let typedValue = value as? T else {
                throw NSError()
            }
            try container.encode(typedValue, forKey: .content)
        }
    }
    
}

public struct Container: Widget, Codable {
    let body: WidgetContainer?
    let content: WidgetContainer
    let footer: WidgetContainer?
}

public struct Vertical: Widget, Codable {
    let children: [WidgetContainer]
}

public struct Text: Widget, Codable {
    let text: String
}

public struct Image: Widget, Codable {
    let image: String
}


let json = """
{
    "type": "container",
    "content": {
        "type": "text",
        "content": {
            "text": "some text"
        }
    }
}
"""

WidgetContainer.register(WidgetContainer.self, for: "container")
WidgetContainer.register(WidgetContainer.self, for: "body")
WidgetContainer.register(WidgetContainer.self, for: "footer")
WidgetContainer.register(WidgetContainer.self, for: "content")
WidgetContainer.register(WidgetContainer.self, for: "children")

//        WidgetContainer.register(Container.self, for: "container")
//WidgetContainer.register(Text.self, for: "text")
//
//if let jsonData = json.data(using: .utf8) {
//    
//    do {
//        let value = try JSONDecoder().decode(WidgetContainer.self, from: jsonData)
//        print("\(value)")
//    } catch {
//        debugPrint("Error: \(error)")
//    }
//}
