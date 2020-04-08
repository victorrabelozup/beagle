/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit
import BeagleUI

struct TabViewScreen: DeeplinkScreen {
    init(path: String, data: [String : String]?) {
    }

    func screenController() -> UIViewController {
        return Beagle.screen(.declarative(screen))
    }
    
    var screen: Screen {
        let tab1 = TabItem(icon: "beagle", content:
            Container(children: [
                Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj"),
                NetworkImage(path: .NETWORK_IMAGE_BEAGLE),
                Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
            ]).applyFlex(Flex().alignContent(.center))
        )

        let tab2 = TabItem(title: "Tab 2 com titulo", content:
            Container(children: [
                Text("Text1 Tab 2"),
                Text("Text2 Tab 2")
            ]).applyFlex(Flex().justifyContent(.center).alignItems(.center))
        )

        let tab3 = TabItem(title: "Tab 3", content:
            Container(children: [
                Text("Text1 Tab 3"),
                Text("Text2 Tab 3")
            ]).applyFlex(Flex().justifyContent(.flexStart))
        )

        let tab4 = TabItem(icon: "beagle", title: "Tab 4", content:
            Container(children: [
                Text("Text1 Tab 4"),
                Text("Text2 Tab 4")
            ]).applyFlex(Flex().alignItems(.center))
        )
        return Screen(navigationBar: NavigationBar(title: "TabView"), child: TabView(tabItems: [tab1, tab2, tab3, tab4], style: .TAB_VIEW_STYLE))
    }
}
