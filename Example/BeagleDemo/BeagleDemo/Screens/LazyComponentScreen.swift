//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct LazyComponentScreen: DeeplinkScreen {
    
    init(path: String, data: [String : String]?) {
    }
    
    func screenController() -> UIViewController {
        return Beagle.screen(.declarative(screen))
    }
    
    var screen: Screen {
        return Screen(
            navigationBar: NavigationBar(title: "Form & LazyComponent"),
            child: Form(
                path: "https://t001-2751a.firebaseapp.com/action/shownativedialog.json",
                method: .get,
                child: Container(children: [
                    Text("Form & LazyComponent"),
                    FormInput(
                        name: "field",
                        child: LazyComponent(
                            path: "http://www.mocky.io/v2/5e4e91c02f00001f2016a8f2",
                            initialState: Text("Loading...")
                        )
                    ),
                    FormSubmit(child:
                        Text("FormSubmit")
                    )
                ]).applyFlex(Flex().justifyContent(.spaceBetween))
            )
        )
    }
}

extension UILabel: OnStateUpdatable {
    public func onUpdateState(component: ServerDrivenComponent) -> Bool {
        guard let w = component as? Text else {
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
