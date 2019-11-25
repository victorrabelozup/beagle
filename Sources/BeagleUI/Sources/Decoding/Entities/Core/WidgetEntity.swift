//
//  WidgetEntity.swift
//  BeagleUI
//
//  Created by Daniel Tes on 21/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

public protocol WidgetEntity: Decodable {}

public typealias WidgetConvertibleEntity = WidgetEntity & WidgetConvertible
