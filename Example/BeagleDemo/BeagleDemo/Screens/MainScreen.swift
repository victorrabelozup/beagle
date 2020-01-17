//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import BeagleUI

struct MainScreen: DeeplinkScreen {
    init() {}
    init(path: String, data: [String : String]?) {}

    var widget: Widget {
        return Container(
            header: NavigationBar(
                title: "Beagle Demo",
                leading: Text("L"),
                trailing: Text("T")
            ),
            content: FlexWidget(children: [
                Navigator(
                    action: Navigate(
                        type: .addView,
                        path: "https://t001-2751a.firebaseapp.com/flow/step1.json"
                    ),
                    child: Button(text: "Navigator")
                ),
                Navigator(
                    action: Navigate(type: .openDeepLink, path: "lazywidget"),
                    child: Button(text: "Lazy Widget")
                ),
                Navigator(
                    action: Navigate(type: .openDeepLink, path: "pageview"),
                    child: Button(text: "Page View")
                ),
                Navigator(
                    action: Navigate(type: .openDeepLink, path: "tabview"),
                    child: Button(text: "Tab View")
                )
            ])
        )
    }
}
