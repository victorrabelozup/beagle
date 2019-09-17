import Foundation

protocol Widget {
    
}

struct Container: Widget {
    let body: Widget?
    let content: Widget
    let footer: Widget?
}

struct Vertical: Widget {
    let children: [Widget]
}

struct Text: Widget {
    let text: String
}

struct Image: Widget {
    let image: String
}

protocol ClassFamily: Decodable {
    
    static var discriminator: Discriminator { get }
    
    func getType() -> Any.Type
}

enum Discriminator: String, CodingKey {
    case type = "type"
}

enum ComponentFamily: String, ClassFamily {
    case container
    case vertical
    case text
    case image
    
    static var discriminator: Discriminator = .type
    
    func getType() -> Any.Type {
        switch self {
        case .container:
            return Container.self
        case .vertical:
            return Vertical.self
        case .text:
            return Text.self
        case .image:
            return Image.self
        }
    }
}

extension JSONDecoder {
    
    //    open func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
    
    func decode<T: ClassFamily, U: Decodable>(family: T.Type, from data: Data) throws -> U {
        return try self.decode(ClassWrapper<T, U>.self, from: data)
    }
    
    private class ClassWrapper<T: ClassFamily, U: Decodable>: Decodable {
        let family: T
        let object: U?
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Discriminator.self)
            family = try container.decode(T.self, forKey: T.discriminator)
            if let type = family.getType() as? U.Type {
                object = try type.init(from: decoder)
            } else {
                object = nil
            }
        }
    }
}

let json = """
{ "type": "container", "content": {
"type": "text"
} }
"""

if let jsonData = json.data(using: .utf8) {
    let decoder = JSONDecoder()
    
    let component = try decoder.decode(ComponentFamily.self, from: jsonData)
    print("\(component)")
}
