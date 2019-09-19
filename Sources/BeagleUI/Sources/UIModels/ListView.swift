//
//  ListView.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct ListView: Widget {
    
    let rows: [Widget]?
    let remoteDataSource: String?
    let loadingState: Widget?
    let direction: ListDirection
    
    init(
        rows: [Widget]? = nil,
        remoteDataSource: String? = nil,
        loadingState: Widget? = nil,
        direction: ListDirection = .vertical
    ) {
        self.rows = rows
        self.remoteDataSource = remoteDataSource
        self.loadingState = loadingState
        self.direction = direction
    }
}

public enum ListDirection {
    case vertical
    case horizontal
}
