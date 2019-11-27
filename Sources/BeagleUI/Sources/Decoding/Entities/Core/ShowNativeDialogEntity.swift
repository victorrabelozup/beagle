//
//  ShowNativeDialogEntity.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 26/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

struct ShowNativeDialogEntity: Decodable {
    let title: String
    let message: String
    let buttonText: String
}

extension ShowNativeDialogEntity: ActionConvertibleEntity {
    func mapToAction() throws -> Action {
        return ShowNativeDialog(title: title, message: message, buttonText: buttonText)
    }
}
