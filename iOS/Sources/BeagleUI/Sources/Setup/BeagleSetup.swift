/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
