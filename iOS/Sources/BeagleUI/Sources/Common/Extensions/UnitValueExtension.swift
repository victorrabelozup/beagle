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
    public static postfix func %(value: Int) -> UnitValue {
        return UnitValue(value: Double(value), type: .percent)
    }
}

extension Float {
    public static postfix func %(value: Float) -> UnitValue {
        return UnitValue(value: Double(value), type: .percent)
    }
}

extension Double {
    public static postfix func %(value: Double) -> UnitValue {
        return UnitValue(value: value, type: .percent)
    }
}


extension UnitValue: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    public init(integerLiteral value: Int) {
        self.init(value: Double(value), type: .real)
    }
    
    public init(floatLiteral value: Float) {
        self.init(value: Double(value), type: .real)
    }
}
