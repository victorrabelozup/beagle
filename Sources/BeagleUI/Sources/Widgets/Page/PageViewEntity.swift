//
//  PageViewEntity.swift
//  BeagleUI
//
//  Created by Yan Dias on 21/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

struct PageViewEntity: WidgetEntity {
    let pages: [AnyDecodableContainer]
    let pageIndicator: AnyDecodableContainer?
}

extension PageViewEntity: WidgetConvertible {
    
    func mapToWidget() throws -> Widget {
        let widgets = try self.pages.map {
            try ($0.content as? WidgetConvertibleEntity)?.mapToWidget()
        }
        
        guard let pages = widgets as? [FlexWidget] else {
            throw WidgetConvertibleError.invalidType
        }

        var pageIndicator: PageIndicator?
        if let indicator = self.pageIndicator {
            if let typed = indicator as? PageIndicator {
                pageIndicator = typed
            } else {
                throw WidgetConvertibleError.invalidType
            }
        }
    
        return PageView(
            pages: pages,
            pageIndicator: pageIndicator
        )
    }
}
