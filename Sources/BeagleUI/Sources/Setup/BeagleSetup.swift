//
//  Copyright © 14/10/19 Daniel Tes. All rights reserved.
//

import Foundation

public class Beagle {

    public static var dependencies: BeagleDependenciesProtocol = BeagleDependencies()

    private init() {}

    // MARK: - Public Functions
    
    /// Register a custom widget
    public static func registerCustomWidget<W: Widget, E: WidgetConvertibleEntity>(
        _ name: String,
        widgetType: W.Type,
        entityType: E.Type
    ) {
        dependencies.decoder.register(entityType, for: name)
    }
}
