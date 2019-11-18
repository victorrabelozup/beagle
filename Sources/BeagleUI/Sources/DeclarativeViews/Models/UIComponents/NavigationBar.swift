//
//  NavigationBar.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 18/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

public struct NavigationBar: NativeWidget {
    
    // MARK: - Public Properties
    
    public let title: String
    
    public init(
        title: String
    ) {
        self.title = title
    }
}
