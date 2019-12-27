//
//  Form.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 12/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct Form: Widget {
    
    // MARK: - Public Properties
    
    public let action: String
    public let method: MethodType
    public let child: Widget
    
    // MARK: - Initialization
    
    public init(
        action: String,
        method: MethodType,
        child: Widget
    ) {
        self.action = action
        self.method = method
        self.child = child
    }
    
    public init(
        action: String,
        method: MethodType,
        @WidgetBuilder _ childBuilder: () -> Widget
    ) {
        let child = childBuilder()
        self.init(action: action, method: method, child: child)
    }
    
}
extension Form {
    public enum MethodType: String, StringRawRepresentable {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}
