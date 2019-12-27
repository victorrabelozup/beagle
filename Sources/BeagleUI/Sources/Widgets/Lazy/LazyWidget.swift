//
//  LazyWidget.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 26/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

 public struct LazyWidget: Widget {
    
    // MARK: - Public Properties
    
    public let url: String
    public let initialState: Widget
        
    // MARK: - Initialization
    
    init(
        url: String,
        initialState: Widget
    ) {
        self.url = url
        self.initialState = initialState
    }
    
    public init(
        url: String,
        @WidgetBuilder _ initialStateBuilder: () -> Widget
    ) {
        let initialState = initialStateBuilder()
        self.init(url: url, initialState: initialState)
    }
}
