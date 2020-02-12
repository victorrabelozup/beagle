//
//  TabViewScreen.swift
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct TabViewScreen: DeeplinkScreen {
    
    init(path: String, data: [String : String]?) {
    }

    func screenController() -> UIViewController {
        return BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(screen))
        )
    }
    
    var screen: Screen {
        let tab1 = TabItem(icon: "beagle", content:
            Container(children: [
                Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj"),
                NetworkImage(path: "https://is5-ssl.mzstatic.com/image/thumb/Purple123/v4/47/b9/9b/47b99ba2-8b0e-9b08-96f6-70cc8a22d773/source/256x256bb.jpg"),
                Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
            ]).applyFlex(Flex(alignContent: .center))
        )

        let tab2 = TabItem(title: "Tab com titulo 2", content:
            Container(children: [
                Text("Text1 Tab 2"),
                Text("Text2 Tab 2")
            ]).applyFlex(Flex(justifyContent: .center, alignItems: .center))
        )

        let tab3 = TabItem(title: "Tab 3", content:
            Container(children: [
                Text("Text1 Tab 3"),
                Text("Text2 Tab 3")
            ]).applyFlex(Flex(justifyContent: .flexStart))
        )

        let tab4 = TabItem(icon: "beagle", title: "Tab 4", content:
            Container(children: [
                Text("Text1 Tab 4"),
                Text("Text2 Tab 4")
            ]).applyFlex(Flex(alignItems: .center))
        )
        return Screen(navigationBar: NavigationBar(title: "TabView"), content: TabView(tabItems: [tab1, tab2, tab3, tab4]))
    }
}
