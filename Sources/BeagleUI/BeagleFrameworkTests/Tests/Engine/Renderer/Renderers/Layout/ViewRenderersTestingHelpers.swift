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
    init(_ widget: Widget) throws {}
    func buildView(context: BeagleContext) -> UIView { return UIView() }
}

class WidgetRendererProviderDummy: WidgetRendererProvider {
    func buildRenderer(for widget: Widget) -> WidgetViewRendererProtocol {
        return WidgetViewRendererProtocolDummy()
    }
}

class BeagleContextDummy: BeagleContext {
    func register(action: Action, inView view: UIView) {}
}
