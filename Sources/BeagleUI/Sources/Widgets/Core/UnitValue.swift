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
    
    static let `default` = UnitValue(value: 0.0, type: .real)
    
}

public enum UnitType {
    case real
    case percent
}
