/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit
import BeagleUI

struct CustomComponentScreen: DeeplinkScreen {
    init(path: String, data: [String : String]?) {
    }
    
    func screenController() -> UIViewController {
        return Beagle.screen(.declarative(screen))
    }
    
    var screen: Screen {
        return Screen(
            navigationBar: NavigationBar(title: "Custom Component"),
            child: Container(
                children: [
                    Text("Here its a custom component\n in this case a Collection View", alignment: .center),
                    DSCollection(
                        flex: Flex().size(Size().width(100%).height(300)),
                        dataSource: DSCollectionDataSource(cards: [
                            DSCollectionDataSource.Card(name: "Pocas", age: 22),
                            DSCollectionDataSource.Card(name: "Borracha", age: 40),
                            DSCollectionDataSource.Card(name: "Gotto", age: 42),
                            DSCollectionDataSource.Card(name: "Tulio", age: 38)
                        ])
                    )
                ]
            )
        )
    }
}
