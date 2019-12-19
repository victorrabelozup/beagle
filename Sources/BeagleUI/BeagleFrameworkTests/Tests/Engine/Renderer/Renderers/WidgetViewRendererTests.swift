//
//  Copyright © 17/10/19 Zup IT. All rights reserved.
//

@testable import BeagleUI

struct RendererDependenciesContainer: ViewRenderer.Dependencies {
    var flex: FlexViewConfiguratorProtocol = FlexViewConfiguratorDummy()
    var rendererProvider: RendererProvider = RendererProviderDummy()
    var theme: Theme = AppThemeDummy()
    var validatorProvider: ValidatorProvider? = ValidatorProviding()
}
