//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct TouchableEntity: ComponentConvertibleEntity {
    
    let action: AnyDecodableContainer
    let child: AnyDecodableContainer
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let componentEntity = self.child.content as? ComponentConvertibleEntity
        let actionEntity = self.action.content as? ActionConvertibleEntity
        
        let child = try componentEntity?.mapToComponent() ?? AnyComponent(value: self.child.content)
        let action = try actionEntity?.mapToAction() ?? AnyAction(value: self.action.content)
        
        return Touchable(
            action: action,
            child: child
        )
    }
}
