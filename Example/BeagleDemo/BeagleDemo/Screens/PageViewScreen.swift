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
            viewModel: .init(screenType: .declarative(widget))
        )
    }
    
    var widget: ScreenWidget {
        return ScreenWidget(
            navigationBar: NavigationBar(title: "PageView"),
            content: PageView(
                pages: Array(repeating: Page(), count: 3).map { $0.content },
                pageIndicator: nil
            )
        )
    }
}

struct Page {
    var content: FlexWidget {
        return FlexWidget(children: [
            Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj",alignment: .center),
            Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj",alignment: .right),
            Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj",alignment: .left),
            NetworkImage(url: "https://is5-ssl.mzstatic.com/image/thumb/Purple123/v4/47/b9/9b/47b99ba2-8b0e-9b08-96f6-70cc8a22d773/source/256x256bb.jpg"),
            Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
        ])
    }
}
