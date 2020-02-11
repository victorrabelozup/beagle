//
//  Copyright © 14/10/19 Daniel Tes. All rights reserved.
//

import Foundation

public class Beagle {

    public static var dependencies: BeagleDependenciesProtocol = BeagleDependencies()

    private init() {}

    // MARK: - Public Functions
    
    /// Register a custom component
    public static func registerCustomComponent<W: ServerDrivenComponent, E: ComponentConvertibleEntity>(
        _ name: String,
        componentType: W.Type,
        entityType: E.Type
    ) {
        dependencies.decoder.register(entityType, for: name)
    }
}
