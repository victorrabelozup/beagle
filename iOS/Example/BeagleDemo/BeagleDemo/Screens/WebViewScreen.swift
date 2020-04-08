/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit
import BeagleUI

struct WebViewScreen: DeeplinkScreen {
    init(path: String, data: [String : String]?) {}
    
    func screenController() -> UIViewController {
        return BeagleScreenViewController(viewModel: .init(screenType: .declarative(screen)))
    }
    
    var screen: Screen {
        return Screen(
            navigationBar: NavigationBar(title: "WebView", showBackButton: true),
            child: webView
        )
    }
    
    var webView: ServerDrivenComponent {
        return WebView(url: .WEB_VIEW_URL, flex: Flex().grow(1))
    }
}
