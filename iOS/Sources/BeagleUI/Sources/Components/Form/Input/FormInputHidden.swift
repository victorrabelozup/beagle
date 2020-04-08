/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

public struct FormInputHidden: FormInputComponent {
    public let name: String
    public let value: String
    
    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
    
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let view = HidenInputView(value: value)
        view.beagleFormElement = self
        view.flex.setup(Flex(positionType: .absolute))
        return view
    }
}

class HidenInputView: UIView, InputValue {
    
    let value: String
    
    init(value: String) {
        self.value = value
        super.init(frame: .zero)
        isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getValue() -> Any {
        return value
    }
}
