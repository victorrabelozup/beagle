/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */


import Foundation
import UIKit

postfix operator %

// swiftlint:disable operator_whitespace

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
