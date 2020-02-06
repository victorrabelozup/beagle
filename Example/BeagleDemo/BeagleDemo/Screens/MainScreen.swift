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
                Button(
                    text: "Navigator",
                    action: Navigate.addView("https://t001-2751a.firebaseapp.com/flow/step1.json")
                ),
                Button(
                    text: "Form & Lazy Widget",
                    action: Navigate.openDeepLink(.init(path: "lazywidget"))
                ),
                Button(
                    text: "Page View",
                    action: Navigate.openDeepLink(.init(path: "pageview"))
                ),
                Button(
                    text: "Tab View",
                    action: Navigate.openDeepLink(.init(path: "tabview"))
                )
            ])
        )

        return BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(screen))
        )
    }
    
}
