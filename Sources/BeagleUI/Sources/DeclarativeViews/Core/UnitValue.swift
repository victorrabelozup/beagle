//
//  UnitValue.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct UnitValue {
    
    public let value: Double
    public let type: UnitType
    
    public static let `default` = UnitValue(value: 0.0, type: .real)
    
    public init(
        value: Double,
        type: UnitType
    ) {
        self.value = value
        self.type = type
    }
    
}

public enum UnitType {
    case real
    case percent
}
