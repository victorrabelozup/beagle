//
//  Copyright © 10/02/20 Zup IT. All rights reserved.
//

public protocol AppearanceComponent: ServerDrivenComponent {
    var appearance: Appearance? { get }
}

public protocol FlexComponent: ServerDrivenComponent {
    var flex: Flex? { get }
}

public protocol Widget: AppearanceComponent, FlexComponent {}
