//
//  Navigate.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 08/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

/// Types of transitions between screens
public enum NavigationType: String, StringRawRepresentable {
    case openDeepLink = "OPEN_DEEP_LINK"
    case swapView = "SWAP_VIEW"
    case addView = "ADD_VIEW"
    case finishView = "FINISH_VIEW"
    case popView = "POP_VIEW"
    case popToView = "POP_TO_VIEW"
    case presentView = "PRESENT_VIEW"
}

/// Action to represent a screen transition
public struct Navigate: Action {
    
    public let type: NavigationType
    public let path: String?
    public let data: [String: String]?
    
    public init(
        type: NavigationType,
        path: String? = nil,
        data: [String: String]? = nil
    ) {
        self.type = type
        self.path = path
        self.data = data
    }
}
