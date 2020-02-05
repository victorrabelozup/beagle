//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct MainScreen: DeeplinkScreen {
    init() {}
    init(path: String, data: [String : String]?) {}
    
    func screenController() -> UIViewController {
        let screen = ScreenWidget(
            navigationBar: .init(title: "Beagle Demo"),
            content: ScrollView(children: [
                Navigator(
                    action: .addView("https://t001-2751a.firebaseapp.com/flow/step1.json"),
                    child: Button(text: "Navigator")
                ),
                Navigator(
                    action: .openDeepLink(.init(path: "lazywidget")),
                    child: Button(text: "Form & Lazy Widget")
                ),
                Navigator(
                    action: .openDeepLink(.init(path: "pageview")),
                    child: Button(text: "Page View")
                ),
                Navigator(
                    action: .openDeepLink(.init(path: "tabview")),
                    child: Button(text: "Tab View")
                )
            ])
        )

        return BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(screen))
        )
    }
    
}
