//
//  ListViewEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ListViewEntity: WidgetEntity {
    
    let rows: [AnyDecodableContainer]
    let remoteDataSource: String?
    let loadingState: AnyDecodableContainer?
    
    enum Direction: String, WidgetEntity {
        case vertical
        case horizontal
    }
    
    func mapToWidget() throws -> Widget {
        
        let rows = try self.rows.compactMap {
            try ($0.content as? WidgetConvertibleEntity)?.mapToWidget()
        }
        
        let widgetEntity = self.loadingState?.content as? WidgetConvertibleEntity
        let loadingState = try widgetEntity?.mapToWidget()
        
        let direction = inferDirection(from: rows)
        
        return ListView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState,
            direction: direction
        )
    }
    
    private func inferDirection(from rows: [Widget]) -> ListView.Direction {
        if rows.first is Horizontal {
            return .horizontal
        }
        return .vertical
    }
}
