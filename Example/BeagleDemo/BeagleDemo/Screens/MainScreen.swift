//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct MainScreen: DeeplinkScreen {
    init() {}
    init(path: String, data: [String : String]?) {}
    
    func screenController() -> UIViewController {
        let screen = Screen(
            navigationBar: .init(title: "Beagle Demo"),
            content: ScrollView(children: [
                Button(
                    text: "Navigator",
                    action: Navigate.addView(.init(path: "https://t001-2751a.firebaseapp.com/flow/step1.json", shouldPrefetch: true))
                ),
                Button(
                    text: "Form & Lazy Component",
                    action: Navigate.openDeepLink(.init(path: "lazycomponent"))
                ),
                Button(
                    text: "Page View",
                    action: Navigate.openDeepLink(.init(path: "pageview"))
                ),
                Button(
                    text: "Tab View",
                    action: Navigate.openDeepLink(.init(path: "tabview"))
                ),
                Button(
                    text: "List View",
                    action: Navigate.openDeepLink(.init(path: "listview"))
                ),
                Button(
                    text: "Form",
                    action: Navigate.openDeepLink(.init(path: "form"))
                ),
                Button(
                    text: "Custom Component",
                    action: Navigate.openDeepLink(.init(path: "customComponent"))
                ),
                Button(
                    text: "Sample BFF",
                    action: Navigate.addView(.init(path: "/sampleComponents", shouldPrefetch: true))
                )
            ])
        )
        
        return Beagle.screen(.declarative(screen))
    }
    
}
