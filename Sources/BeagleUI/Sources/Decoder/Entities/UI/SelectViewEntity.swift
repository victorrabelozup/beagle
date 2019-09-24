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
    
    let rows: [WidgetEntity]?
    let remoteDataSource: String?
    let loadingState: WidgetEntity?
    
    private let rowsContainer: [WidgetEntityContainer]?
    private let loadingStateContainer: WidgetEntityContainer?
    
    enum CodingKeys: String, CodingKey {
        case rowsContainer = "rows"
        case remoteDataSource
        case loadingStateContainer = "loadingState"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        rowsContainer = try container.decodeIfPresent([WidgetEntityContainer].self, forKey: .rowsContainer)
        rows = rowsContainer?.compactMap { $0.content }
        
        remoteDataSource = try container.decodeIfPresent(String.self, forKey: .remoteDataSource)
        
        loadingStateContainer = try container.decodeIfPresent(WidgetEntityContainer.self, forKey: .loadingStateContainer)
        loadingState = loadingStateContainer?.content
    }
    
    init(
        rowsContainer: [WidgetEntityContainer]?,
        remoteDataSource: String?,
        loadingStateContainer: WidgetEntityContainer?
    ) {
        self.rowsContainer = rowsContainer
        rows = rowsContainer?.compactMap { $0.content }
        self.remoteDataSource = remoteDataSource
        self.loadingStateContainer = loadingStateContainer
        self.loadingState = loadingStateContainer?.content
    }
    
}
extension SelectViewEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        let rows = self.rowsContainer?.compactMap { try? $0.content?.mapToWidget() }
        let loadingState = try? self.loadingStateContainer?.content?.mapToWidget()
        return SelectView(rows: rows, remoteDataSource: remoteDataSource, loadingState: loadingState)
    }
}
