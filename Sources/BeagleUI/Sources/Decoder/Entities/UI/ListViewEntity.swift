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
    
    let rows: [WidgetEntity]?
    let remoteDataSource: String?
    let loadingState: WidgetEntity?
    let direction: Direction
    
    private let rowsContainer: [WidgetEntityContainer]?
    private let loadingStateContainer: WidgetEntityContainer?
    
    enum CodingKeys: String, CodingKey {
        case rowsContainer = "rows"
        case remoteDataSource
        case loadingStateContainer = "loadingState"
        case direction
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        rowsContainer = try container.decodeIfPresent([WidgetEntityContainer].self, forKey: .rowsContainer)
        rows = rowsContainer?.compactMap { $0.content }
        
        remoteDataSource = try container.decodeIfPresent(String.self, forKey: .remoteDataSource)
        
        loadingStateContainer = try container.decodeIfPresent(WidgetEntityContainer.self, forKey: .loadingStateContainer)
        loadingState = loadingStateContainer?.content
        
        direction = try container.decode(Direction.self, forKey: .remoteDataSource)
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
        
        let rows = self.rowsContainer?.compactMap { try? $0.content?.mapToWidget() }
        let loadingState = try? self.loadingStateContainer?.content?.mapToWidget()
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
