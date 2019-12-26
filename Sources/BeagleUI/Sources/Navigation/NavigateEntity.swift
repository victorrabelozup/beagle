//
//  NavigateEntity.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 08/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

enum NavigationTypeEntity: String, Decodable, UIEnumModelConvertible {
    case openDeepLink = "OPEN_DEEP_LINK"
    case swapView = "SWAP_VIEW"
    case addView = "ADD_VIEW"
    case finishView = "FINISH_VIEW"
    case popView = "POP_VIEW"
    case popToView = "POP_TO_VIEW"
    case presentView = "PRESENT_VIEW"
}

struct NavigateEntity: Decodable {
    let type: NavigationTypeEntity
    let path: String?
    let data: [String: String]?
}

extension NavigateEntity: UIModelConvertible {
    func mapToUIModel() throws -> Navigate {
        return Navigate(
            type: try type.mapToUIModel(ofType: NavigationType.self),
            path: path,
            data: data)
    }
}

extension NavigateEntity: ActionConvertibleEntity {
    func mapToAction() throws -> Action {
        return try mapToUIModel()
    }
}
