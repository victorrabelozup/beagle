//
//  UnitValueEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct UnitValueEntity: Decodable {
    
    public let value: Double
    public let type: UnitTypeEntity
    
    public static let zero = UnitValueEntity(value: 0.0, type: .real)
}

extension UnitValueEntity: UIModelConvertible {
    
    public func mapToUIModel() throws -> UnitValue {
        let type = mapType()
        return UnitValue(value: value, type: type)
    }
    
    private func mapType() -> UnitType {
        switch type {
        case .auto:
            return .auto
        case .real:
            return .real
        case .percent:
            return .percent
        }
    }
}

public enum UnitTypeEntity: String, Decodable {
    case auto = "AUTO"
    case real = "REAL"
    case percent = "PERCENT"
}
