//
//  UnitValueExtension.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 06/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation
import UIKit

postfix operator %
extension Int {
    public static postfix func % (value: Int) -> UnitValue {
        return UnitValue(value: Double(value), type: .percent)
    }
}
