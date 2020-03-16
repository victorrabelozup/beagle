//
//  UnitValue.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct UnitValue: Decodable {
    
    // MARK: - Constants
    
    public static let zero = UnitValue(value: 0.0, type: .real)
    public static let auto = UnitValue(value: 0.0, type: .auto)
    
    // MARK: - Public Properties
    
    public let value: Double
    public let type: UnitType
    
    // MARK: - Initialization
    
    public init(
        value: Double,
        type: UnitType
    ) {
        self.value = value
        self.type = type
    }
    
}

public enum UnitType: String, Decodable {
    case auto = "AUTO"
    case real = "REAL"
    case percent = "PERCENT"
}
