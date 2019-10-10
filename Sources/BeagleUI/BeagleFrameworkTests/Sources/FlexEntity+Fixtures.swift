//
//  FlexEntity+Fixtures.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 20/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation
@testable import BeagleUI

extension FlexEntity {
    
    static func fixture(
        flexWrap: Wrap = .noWrap,
        justifyContent: JustifyContent = .flexEnd,
        alignItems: Alignment = .stretch,
        alignSelf: Alignment = .auto,
        alignContent: Alignment = .flexStart,
        basis: UnitValueEntity = UnitValueEntity(value: 0.0, type: .real),
        grow: Double = 0.0,
        shrink: Double = 0.0
    ) -> FlexEntity {
        return FlexEntity(
            flexWrap: flexWrap,
            justifyContent: justifyContent,
            alignItems: alignItems,
            alignSelf: alignSelf,
            alignContent: alignContent,
            basis: basis,
            grow: grow,
            shrink: shrink
        )
    }
    
}
