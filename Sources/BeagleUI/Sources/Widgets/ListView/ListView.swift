//
//  ListView.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct ListView: Widget {
    
    // MARK: - Public Properties
    
    public let rows: [Widget]?
    public let remoteDataSource: String?
    public let loadingState: Widget?
    public let direction: Direction
    
    // MARK: - Initialization
    
    public init(
        rows: [Widget]? = nil,
        remoteDataSource: String? = nil,
        loadingState: Widget? = nil,
        direction: Direction = .vertical
    ) {
        self.rows = rows
        self.remoteDataSource = remoteDataSource
        self.loadingState = loadingState
        self.direction = direction
    }
    
    // MARK: - Configuration
    
    public func remoteDataSource(_ remoteDataSource: String) -> ListView {
        return ListView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState,
            direction: direction
        )
    }
    
    public func loadingState(_ loadingStateBuilder: () -> Widget) -> ListView {
        let loadingState = loadingStateBuilder()
        return ListView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState,
            direction: direction
        )
    }
    
    public func direction(_ direction: Direction) -> ListView {
        return ListView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState,
            direction: direction
        )
    }
}

extension ListView {
    
    public enum Direction {
        
        case vertical
        case horizontal
        
        func toUIKit() -> UICollectionView.ScrollDirection {
            switch self {
            case .horizontal:
                return .horizontal
            case .vertical:
                return .vertical
            }
        }
    }
}
