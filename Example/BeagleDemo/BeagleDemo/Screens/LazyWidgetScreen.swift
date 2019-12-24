//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct LazyWidgetScreen: DeeplinkScreen {
    init(path: String, data: [String : String]?) {
    }
    var widget: Widget {
        Form(
        action: "https://t001-2751a.firebaseapp.com/action/shownativedialog.json", method: .get) {
            FlexWidget {
                Text("Form & LazyWidget")
                FormInput(name: "field") {
                    LazyWidget(url: "http://www.mocky.io/v2/5de16c0a32000056638093da") {
                        Text("Loading...")
                    }
                }
                FormSubmit {
                    Text("FormSubmit")
                }
            }
            .applyFlex(Flex(justifyContent: .spaceBetween))
        }
    }
}

extension UILabel: OnStateUpdatable {
    public func onUpdateState(widget: Widget) -> Bool {
        guard let w = widget as? Text else {
            return false
        }
        text = w.text
        return true
    }
}
