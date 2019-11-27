//
//  ActionGestureRecognizer.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 22/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class ActionGestureRecognizer: UITapGestureRecognizer {
    
    let action: Action
    
    init(action: Action, target: Any?, selector: Selector?) {
        self.action = action
        super.init(target: target, action: selector)
    }
}
