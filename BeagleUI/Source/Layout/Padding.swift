//
//  Padding.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct Padding: Widget {
    let value: PaddingValue
    let child: Widget
}

struct PaddingValue {
    let top: UnitValue?
    let left: UnitValue?
    let right: UnitValue?
    let bottom: UnitValue?
}
