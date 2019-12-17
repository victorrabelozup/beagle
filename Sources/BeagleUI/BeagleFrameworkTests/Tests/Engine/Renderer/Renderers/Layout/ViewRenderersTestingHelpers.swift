//
//  ViewRenderersTestingHelpers.swift
//  BeagleFrameworkTests
//
//  Created by Yan Dias on 21/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

// MARK: - Testing Helpers

final class WidgetViewRendererProtocolDummy: WidgetViewRendererProtocol {
    init() { }
    init(widget: Widget, dependencies: RendererDependencies?) throws {}
    func buildView(context: BeagleContext) -> UIView { return UIView() }
}

class WidgetRendererProviderDummy: WidgetRendererProvider {
    func buildRenderer(for widget: Widget, dependencies: RendererDependencies) -> WidgetViewRendererProtocol {
        return WidgetViewRendererProtocolDummy()
    }
}

class BeagleContextDummy: BeagleContext {
    var screenController: UIViewController = UIViewController()
    func register(action: Action, inView view: UIView) {}
    func register(form: Form, formView: UIView, submitView: UIView, validator: ValidatorProvider?) {}
    func lazyLoad(url: String, initialState: UIView) {}
}
