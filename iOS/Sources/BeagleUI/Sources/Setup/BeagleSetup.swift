//
//  Copyright © 14/10/19 Daniel Tes. All rights reserved.
//

import Foundation

public class Beagle {

    public static var dependencies: BeagleDependenciesProtocol = BeagleDependencies()

    private init() {}

    // MARK: - Public Functions
    
    /// Register a custom component
    public static func registerCustomComponent<C: ServerDrivenComponent>(
        _ name: String,
        componentType: C.Type
    ) {
        dependencies.decoder.register(componentType, for: name)
    }

    public static func screen(_ type: BeagleScreenViewModel.ScreenType) -> BeagleScreenViewController {
        return BeagleScreenViewController(viewModel: .init(screenType: type))
    }
}
