/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
                action: FormRemoteAction(path: .TEXT_FORM_ENDPOINT, method: .get),
                child: Container(children: [
                    Text("Form & LazyComponent"),
                    FormInput(
                        name: "field",
                        child: LazyComponent(
                            path: .TEXT_LAZY_COMPONENTS_ENDPOINT,
                            initialState: Text("Loading...")
                        )
                    ),
                    Text("Text above input hidden"),
                    FormInputHidden(name: "id", value: "123"),
                    FormInputHidden(name: "age", value: "45"),
                    Text("Text bellow input hiden"),
                    FormSubmit(child:
                        Text("FormSubmit")
                    )
                ]).applyFlex(Flex().justifyContent(.spaceBetween))
            )
        )
    }
}

extension UITextView: OnStateUpdatable {
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
