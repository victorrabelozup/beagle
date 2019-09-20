//
//  SimpleURLRequest.swift
//  Networking
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Bocato. All rights reserved.
//

import Foundation

public struct SimpleURLRequest: URLRequestProtocol {
    
    public var baseURL: URL
    public var path: String? = nil
    public var method: HTTPMethod
    public var parameters: URLRequestParameters? = nil
    public var headers: [String : Any]? = nil
    
    init(baseURL: URL,
         method: HTTPMethod = .get) {
        self.baseURL = baseURL
        self.method = method
    }
    
}
