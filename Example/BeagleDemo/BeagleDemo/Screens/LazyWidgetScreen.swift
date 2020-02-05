//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct LazyWidgetScreen: DeeplinkScreen {
    
    init(path: String, data: [String : String]?) {
    }
    
    func screenController() -> UIViewController {
        return BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(widget.toScreen()))
        )
    }
    
    var widget: ScreenWidget {
        return ScreenWidget(
            navigationBar: NavigationBar(title: "Form & LazyWidget"),
            content: Form(
                action: "https://t001-2751a.firebaseapp.com/action/shownativedialog.json",
                method: .get,
                child: FlexWidget(children: [
                    Text("Form & LazyWidget"),
                    FormInput(
                        name: "field",
                        child: LazyWidget(
                            url: "http://www.mocky.io/v2/5de16c0a32000056638093da",
                            initialState: Text("Loading...")
                        )
                    ),
                    FormSubmit(child:
                        Text("FormSubmit")
                    )
                ]).applyFlex(Flex(justifyContent: .spaceBetween))
            )
        )
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

extension UILabel: InputValue {
    public func getValue() -> Any {
        return text ?? ""
    }
}
