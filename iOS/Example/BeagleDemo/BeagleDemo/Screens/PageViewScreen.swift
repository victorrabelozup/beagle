//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct PageViewScreen: DeeplinkScreen {
    init(path: String, data: [String : String]?) {
    }
    
    func screenController() -> UIViewController {
        return Beagle.screen(.declarative(screen))
    }
    
    var screen: Screen {
        return Screen(
            navigationBar: NavigationBar(title: "PageView"),
            child: PageView(
                pages: Array(repeating: Page(), count: 3).map { $0.content },
                pageIndicator: PageIndicator()
            )
        )
    }
}

struct Page {
    var content: Container {
        return Container(children: [
            Text("Text with alignment atribute set to center",alignment: .center),
            Text("Text with alignment atribute set to right",alignment: .right),
            Text("Text with alignment atribute set to left",alignment: .left),
            NetworkImage(path:.NETWORK_IMAGE_BEAGLE),
        ],
            flex: Flex().justifyContent(.spaceBetween).grow(1)
        )
    }
}
