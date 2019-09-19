//
//  ListViewEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `ListView`
struct ListViewEntity: WidgetEntity {
    let rows: [WidgetEntityContainer]?
    let remoteDataSource: String?
    let loadingState: WidgetEntityContainer?
    let direction: ListDirectionEntity
}
extension ListViewEntity: WidgetConvertible {
    
    func mapToWidget() throws -> Widget {
        
        let rows = self.rows?.compactMap { try? $0.content?.mapToWidget() }
        let loadingState = try? self.loadingState?.content?.mapToWidget()
        let direction = mapDirection()
        
        return ListView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState,
            direction: direction
        )
    }
    
    private func mapDirection() -> ListDirection {
        switch direction {
        case .horizontal:
            return .horizontal
        case .vertical:
            return .vertical
        }
    }
    
}

/// Defines an API representation for `ListDirection`
enum ListDirectionEntity: String, WidgetEntity {
    case vertical
    case horizontal
}
