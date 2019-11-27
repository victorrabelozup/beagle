//
//  ActionConvertible.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 26/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

public protocol ActionConvertible {
    func mapToAction() throws -> Action
}
