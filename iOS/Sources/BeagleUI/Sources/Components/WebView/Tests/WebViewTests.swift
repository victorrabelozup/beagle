/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
import SnapshotTesting
import WebKit
@testable import BeagleUI

final class WebViewTests: XCTestCase {
    
    func test_whenDecondingJson_shouldReturnAWebView() throws {
        let component: WebView = try componentFromJsonFile(fileName: "WebView")
        assertSnapshot(matching: component, as: .dump)
    }
    
    func test_renderWebViewComponent() throws {
        let component: WebView = try componentFromJsonFile(fileName: "WebView")
        let view = component.toView(context: BeagleContextDummy(), dependencies: BeagleDependencies())
        assert(view is WebViewUIComponent)
    }
}
