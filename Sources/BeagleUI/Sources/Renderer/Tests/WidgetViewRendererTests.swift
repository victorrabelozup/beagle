//
//  Copyright © 17/10/19 Zup IT. All rights reserved.
//

@testable import BeagleUI

struct RendererDependenciesContainer: ViewRenderer.Dependencies {
    var flex: FlexViewConfiguratorProtocol
    var rendererProvider: RendererProvider
    var theme: Theme
    var validatorProvider: ValidatorProvider?
    var appBundle: Bundle

    init(
        flex: FlexViewConfiguratorProtocol = FlexViewConfiguratorDummy(),
        rendererProvider: RendererProvider = RendererProviding(),
        theme: Theme = AppThemeDummy(),
        validatorProvider: ValidatorProvider? = ValidatorProviding(),
        appBundle: Bundle = Bundle(for: ImageTests.self)
    ) {
        self.flex = flex
        self.rendererProvider = rendererProvider
        self.theme = theme
        self.validatorProvider = validatorProvider
        self.appBundle = appBundle
    }
}
