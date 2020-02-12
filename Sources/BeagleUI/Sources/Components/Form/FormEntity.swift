//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct FormEntity: ComponentConvertibleEntity {
    
    let path: String
    let method: MethodType
    let child: AnyDecodableContainer
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let componentEntity = self.child.content as? ComponentConvertibleEntity
        let child = try componentEntity?.mapToComponent() ?? AnyComponent(value: self.child.content)
        let method = try self.method.mapToUIModel(ofType: Form.MethodType.self)
        return Form(
            path: path,
            method: method,
            child: child
        )
    }
}

extension FormEntity {
    enum MethodType: String, ComponentEntity, UIEnumModelConvertible {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}
