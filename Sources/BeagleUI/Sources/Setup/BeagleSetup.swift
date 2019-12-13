//
//  Copyright © 14/10/19 Daniel Tes. All rights reserved.
//

import Foundation

@dynamicMemberLookup
public class Beagle {

    public static var dependencies: BeagleDependenciesProtocol = BeagleDependencies(appName: "Beagle")

    private init() {}

    // MARK: - Public Functions
    
    /// Register a single custom widget and entity
    public static func registerCustomWidget<E: WidgetConvertibleEntity, W: Widget>(
        _ item: WidgetRegisterItem<E, W>
    ) {
        dependencies.decoder.register(item.entity.type, for: item.entity.typeName)
        dependencies.customWidgetsProvider.registerRenderer(
            item.view.viewRenderer, for: item.view.widgetType
        )
    }

    public static subscript<T>(dynamicMember keyPath: KeyPath<BeagleDependenciesProtocol, T>) -> T {
        return dependencies[keyPath: keyPath]
    }
}
