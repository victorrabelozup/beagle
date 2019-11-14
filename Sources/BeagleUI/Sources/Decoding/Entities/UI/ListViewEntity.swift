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
    
    let rows: [WidgetConvertibleEntity]
    let remoteDataSource: String?
    let loadingState: WidgetConvertibleEntity?
    
    private let rowsContainer: [WidgetEntityContainer]?
    private let loadingStateContainer: WidgetEntityContainer?
    
    private enum CodingKeys: String, CodingKey {
        case rowsContainer = "rows"
        case remoteDataSource
        case loadingStateContainer = "loadingState"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            rowsContainer: container.decodeIfPresent([WidgetEntityContainer].self, forKey: .rowsContainer),
            remoteDataSource: container.decodeIfPresent(String.self, forKey: .remoteDataSource),
            loadingStateContainer: container.decodeIfPresent(WidgetEntityContainer.self, forKey: .loadingStateContainer)
        )
    }
    
    init(
        rowsContainer: [WidgetEntityContainer]?,
        remoteDataSource: String?,
        loadingStateContainer: WidgetEntityContainer?
    ) {
        
        self.rowsContainer = rowsContainer
        var rows = [WidgetConvertibleEntity]()
        if let rowsContainer = rowsContainer {
            rows = rowsContainer.compactMap { $0.content }
        }
        self.rows = rows
        
        self.remoteDataSource = remoteDataSource
        
        self.loadingStateContainer = loadingStateContainer
        loadingState = loadingStateContainer?.content
    }
    
}
extension ListViewEntity {
    /// Defines an API representation for `ListDirection`
    enum Direction: String, WidgetEntity {
        case vertical
        case horizontal
    }
}
extension ListViewEntity: WidgetConvertible {
    
    func mapToWidget() throws -> Widget {
        
        let rows = try self.rows.compactMap { try $0.mapToWidget() }
        let loadingState = try self.loadingState?.mapToWidget()
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
