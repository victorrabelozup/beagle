//
//  FormSubmit.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 12/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct FormSubmit: NativeWidget {
    
    // MARK: - Public Properties
    
    public let child: Widget
    
    // MARK: - Initialization
    
    init(
        child: Widget
    ) {
        self.child = child
    }
    
    public init(
        @WidgetBuilder _ childBuilder: () -> Widget
    ) {
        let child = childBuilder()
        self.init(child: child)
    }
    
}
