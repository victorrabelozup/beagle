//
//  Copyright © 10/02/20 Zup IT. All rights reserved.
//

protocol AppearanceComponent: ServerDrivenComponent {
    var appearance: Appearance? { get }
}

protocol FlexComponent: ServerDrivenComponent {
    var flex: Flex? { get }
}

protocol Widget: AppearanceComponent, FlexComponent {}
