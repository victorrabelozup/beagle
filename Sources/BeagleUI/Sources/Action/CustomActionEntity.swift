//
//  CustomActionEntity.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 26/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

struct CustomActionEntity: Decodable {
    let name: String
    let data: [String: String]
}

extension CustomActionEntity: ActionConvertibleEntity {
    func mapToAction() throws -> Action {
        return CustomAction(name: name, data: data)
    }
}
