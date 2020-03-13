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
            child: ScrollView(children: [
                Button(
                    text: "Navigator",
                    action: Navigate.addView(.init(path: .NAVIGATE_ENDPOINT, shouldPrefetch: true))
                ),
                Button(
                    text: "Form & Lazy Component",
                    action: Navigate.openDeepLink(.init(path: .LAZY_COMPONENTS_ENDPOINT ))
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
                    text: "Sample BFF",
                    action: Navigate.addView(.init(path: .COMPONENTS_ENDPOINT))
                )
            ])
        )
        
        return Beagle.screen(.declarative(screen))
    }
    
}
