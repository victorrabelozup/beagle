//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct TouchableEntity: WidgetConvertibleEntity {
    
    let action: AnyDecodableContainer
    let child: AnyDecodableContainer
    
    func mapToWidget() throws -> Widget {
        let widgetEntity = self.child.content as? WidgetConvertibleEntity
        let actionEntity = self.action.content as? ActionConvertibleEntity
        
        let child = try widgetEntity?.mapToWidget() ?? AnyWidget(value: self.child.content)
        let action = try actionEntity?.mapToAction() ?? AnyAction(value: self.action.content)
        
        return Touchable(
            action: action,
            child: child
        )
    }
}
