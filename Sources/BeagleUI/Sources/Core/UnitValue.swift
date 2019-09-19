//
//  UnitValue.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct UnitValue {
    let value: Double
    let type: UnitType
}

public enum UnitType {
    case real
    case percent
}
