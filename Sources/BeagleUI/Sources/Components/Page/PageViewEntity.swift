//
//  PageViewEntity.swift
//  BeagleUI
//
//  Created by Yan Dias on 21/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

struct PageViewEntity: ComponentEntity {
    let pages: [AnyDecodableContainer]
    let pageIndicator: AnyDecodableContainer?
}

extension PageViewEntity: ComponentConvertible {
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let components = try pages.map {
            try ($0.content as? ComponentConvertibleEntity)?.mapToComponent()
        }
        
        guard let pages = components as? [ServerDrivenComponent] else {
            throw ComponentConvertibleError.invalidType
        }
    
        return PageView(
            pages: pages,
            pageIndicator: try getPageIndicatorComponent()
        )
    }

    private func getPageIndicatorComponent() throws -> PageIndicator? {
        guard let indicator = pageIndicator else { return nil }

        let component = try (indicator.content as? ComponentConvertibleEntity)?.mapToComponent()
        if let typed = component as? PageIndicator {
            return typed
        } else {
            throw ComponentConvertibleError.invalidType
        }
    }
}
