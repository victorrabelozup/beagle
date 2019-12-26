//
//  Copyright © 21/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

// MARK: - Testing Helpers

final class ViewRendererProtocolDummy: ViewRenderer {
    init() { }
    init(widget: Widget, dependencies: ViewRenderer.Dependencies) throws {}
    func buildView(context: BeagleContext) -> UIView { return UIView() }
}

class RendererProviderDummy: RendererProvider {
    func buildRenderer(for widget: Widget, dependencies: ViewRenderer.Dependencies) -> ViewRenderer {
        return ViewRendererProtocolDummy()
    }
}

class BeagleContextDummy: BeagleContext {
    var screenController: UIViewController = UIViewController()
    
    func register(action: Action, inView view: UIView) {}
    func register(form: Form, formView: UIView, submitView: UIView, validator: ValidatorProvider?) {}
    func lazyLoad(url: String, initialState: UIView) {}
    func doAction(_ action: Action, sender: Any) {}
}
