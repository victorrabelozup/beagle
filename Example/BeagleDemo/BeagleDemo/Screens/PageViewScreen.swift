//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct PageViewScreen: DeeplinkScreen {
    init(path: String, data: [String : String]?) {
    }
    
    func screenController() -> UIViewController {
        return BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(screen))
        )
    }
    
    var screen: Screen {
        return Screen(
            navigationBar: NavigationBar(title: "PageView"),
            content: PageView(
                pages: Array(repeating: Page(), count: 3).map { $0.content },
                pageIndicator: DefaultPageIndicator()
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
            NetworkImage(path: "https://www.petlove.com.br/images/breeds/193436/profile/original/beagle-p.jpg?1532538271"),
        ],
            flex: Flex(justifyContent: .spaceBetween, grow: 1)
        )
    }
}
