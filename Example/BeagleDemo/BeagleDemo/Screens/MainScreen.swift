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
                Touchable(
                    action: Navigate.addView("https://t001-2751a.firebaseapp.com/flow/step1.json"),
                    child: Button(text: "Navigator")
                ),
                Touchable(
                    action: Navigate.openDeepLink(.init(path: "lazywidget")),
                    child: Button(text: "Form & Lazy Widget")
                ),
                Touchable(
                    action: Navigate.openDeepLink(.init(path: "pageview")),
                    child: Button(text: "Page View")
                ),
                Touchable(
                    action: Navigate.openDeepLink(.init(path: "tabview")),
                    child: Button(text: "Tab View")
                )
            ])
        )

        return BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(screen))
        )
    }
    
}
