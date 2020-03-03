//
//  Copyright © 2019 Zup IT. All rights reserved.
//

public protocol ComponentEntity: Decodable {}

public typealias ComponentConvertibleEntity = ComponentEntity & ComponentConvertible

public protocol WidgetEntity: ComponentConvertibleEntity {
    var flex: FlexEntity? { get }
    var appearance: AppearanceEntity? { get }
    var accessibility: AccessibilityEntity? { get }
    var id: String? { get }
}
