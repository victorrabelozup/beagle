//
//  PageViewScreen.swift
//  BeagleDemo
//
//  Created by Lucas Araújo on 03/12/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct PageViewScreen: DeeplinkScreen {
    init(path: String, data: [String : String]?) {
    }
    var widget: Widget {
        PageView(
            pages: Array(repeating: Page(), count: 3).map { $0.content },
            pageIndicator: nil
        )
    }
}

struct Page {
    var content: FlexWidget {
        FlexWidget {
            Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
            NetworkImage(url: "https://is5-ssl.mzstatic.com/image/thumb/Purple123/v4/47/b9/9b/47b99ba2-8b0e-9b08-96f6-70cc8a22d773/source/256x256bb.jpg")
            Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
        }
    }
}
