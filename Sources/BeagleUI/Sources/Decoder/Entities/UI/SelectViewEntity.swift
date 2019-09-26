//
//  SelectViewEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `SelectView`
struct SelectViewEntity: WidgetEntity {
    
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
        rows = rowsContainer?.compactMap { $0.content } ?? []
        self.remoteDataSource = remoteDataSource
        self.loadingStateContainer = loadingStateContainer
        self.loadingState = loadingStateContainer?.content
    }
    
}
extension SelectViewEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        let rows = try self.rows.compactMap { try $0.mapToWidget() }
        let loadingState = try self.loadingState?.mapToWidget()
        return SelectView(rows: rows, remoteDataSource: remoteDataSource, loadingState: loadingState)
    }
}
