/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
