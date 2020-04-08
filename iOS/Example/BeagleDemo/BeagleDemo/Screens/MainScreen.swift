/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit
import BeagleUI

struct MainScreen: DeeplinkScreen {
    init() {}
    init(path: String, data: [String : String]?) {}
    
    func screenController() -> UIViewController {
        let screen = Screen(
            navigationBar: buildNavigationBar(),
            child: buildChild()
        )

        return BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(screen))
        )
    }
    
    private func buildChild() -> ScrollView {
        return ScrollView(
            children: [
                Button(
                    text: "Navigator",
                    action: Navigate.addView(.init(path: .NAVIGATE_ENDPOINT, shouldPrefetch: true))
                ),
                Button(
                    text: "Form & Lazy Component",
                    action: Navigate.openDeepLink(.init(path: .LAZY_COMPONENTS_ENDPOINT))
                ),
                Button(
                    text: "Page View",
                    action: Navigate.openDeepLink(.init(path: .PAGE_VIEW_ENDPOINT))
                ),
                Button(
                    text: "Tab View",
                    action: Navigate.openDeepLink(.init(path: .TAB_VIEW_ENDPOINT))
                ),
                Button(
                    text: "List View",
                    action: Navigate.openDeepLink(.init(path: .LIST_VIEW_ENDPOINT))
                ),
                Button(
                    text: "Form",
                    action: Navigate.openDeepLink(.init(path: .FORM_ENDPOINT))
                ),
                Button(
                    text: "Custom Component",
                    action: Navigate.openDeepLink(.init(path: .CUSTOM_COMPONENT_ENDPOINT))
                ),
                Button(
                    text: "Web View",
                    action: Navigate.openDeepLink(.init(path: .WEB_VIEW_ENDPOINT))
                ),
                Button(
                    text: "Sample BFF",
                    action: Navigate.addView(.init(path: .COMPONENTS_ENDPOINT))
                )
            ]
        )
    }
    
    private func buildNavigationBar() -> NavigationBar {
        return NavigationBar(
            title: "Beagle Demo"
        )
    }

}
