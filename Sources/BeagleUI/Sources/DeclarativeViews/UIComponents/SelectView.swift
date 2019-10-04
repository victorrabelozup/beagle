//
//  SelectView.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct SelectView: UIComponentWidget {
    
    // MARK: - Public Properties
    
    public let rows: [Widget]
    public let remoteDataSource: String?
    public let loadingState: Widget?
    
    // MARK: - Initialization
    
    init(
        rows: [Widget] = [],
        remoteDataSource: String? = nil,
        loadingState: Widget? = nil
    ) {
        self.rows = rows
        self.remoteDataSource = remoteDataSource
        self.loadingState = loadingState
    }
    
    public init(
        @WidgetBuilder _ rowBuilder: () -> Widget
    ) {
        let singleRow = rowBuilder()
        self.init(rows: [singleRow])
    }
    
    public init(
        @WidgetArrayBuilder _ rowsBuilder: () -> [Widget]
    ) {
        let rows = rowsBuilder()
        self.init(rows: rows)
    }
    
    // MARK: - Configuration
    
    public func remoteDataSource(_ remoteDataSource: String) -> SelectView {
        return SelectView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState
        )
    }
    
    public func loadingState(_ loadingStateBuilder: () -> Widget) -> SelectView {
        let loadingState = loadingStateBuilder()
        return SelectView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState
        )
    }
    
}
