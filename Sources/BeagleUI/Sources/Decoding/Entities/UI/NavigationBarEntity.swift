//
//  NavigationBarEntity.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 18/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

/// Defines an API representation for `NavigationBar`
struct NavigationBarEntity: WidgetEntity {
    let title: String
    
    init(
        title: String
    ) {
        self.title = title
    }
}

extension NavigationBarEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        return NavigationBar(title: title)
    }
}
