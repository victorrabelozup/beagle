//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct FormInputEntity: ComponentConvertibleEntity {
    
    let name: String
    let required: Bool?
    let validator: String?
    let errorMessage: String?
    let child: AnyDecodableContainer
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let componentEntity = self.child.content as? ComponentConvertibleEntity
        let child = try componentEntity?.mapToComponent() ?? AnyComponent(value: self.child.content)
        return FormInput(
            name: name,
            required: required,
            validator: validator,
            errorMessage: errorMessage,
            child: child
        )
    }
}
