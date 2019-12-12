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
        let widgets = try pages.map {
            try ($0.content as? WidgetConvertibleEntity)?.mapToWidget()
        }
        
        guard let pages = widgets as? [Widget] else {
            throw WidgetConvertibleError.invalidType
        }
    
        return PageView(
            pages: pages,
            pageIndicator: try getPageIndicatorWidget()
        )
    }

    private func getPageIndicatorWidget() throws -> PageIndicator? {
        guard let indicator = pageIndicator else { return nil }

        let widget = try (indicator.content as? WidgetConvertibleEntity)?.mapToWidget()
        if let typed = widget as? PageIndicator {
            return typed
        } else {
            throw WidgetConvertibleError.invalidType
        }
    }
}
