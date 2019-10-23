//
//  ServerDrivenScreenLoader.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 17/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit
import Networking

public enum ServerDrivenScreenLoaderError: Error {
    case fetchError(ServerDrivenWidgetFetcherError)
}

public protocol ServerDrivenScreenLoader {
    func loadScreen(from url: URL, then: @escaping (Result<UIView, ServerDrivenScreenLoaderError>) -> Void)
}

public final class ServerDrivenScreenLoading: ServerDrivenScreenLoader {
    
    // MARK: - Dependencies
    
    private let widgetFetcher: ServerDrivenWidgetFetcher
    private let viewBuilder: BeagleViewBuilder
    
    // MARK: - Initialization
    
    public convenience init() {
        self.init(
            widgetFetcher: ServerDrivenWidgetFetching(),
            viewBuilder: BeagleViewBuilding()
        )
    }
    
    init(
        widgetFetcher: ServerDrivenWidgetFetcher,
        viewBuilder: BeagleViewBuilder
    ) {
        self.widgetFetcher = widgetFetcher
        self.viewBuilder = viewBuilder
    }
    
    // MARK: - Public functions
    
    public func loadScreen(from url: URL, then: @escaping (Result<UIView, ServerDrivenScreenLoaderError>) -> Void) {
        widgetFetcher.fetchWidget(from: url) {
            let mappedResult: Result<UIView, ServerDrivenScreenLoaderError> = $0
                .map { self.viewBuilder.buildFromRootWidget($0) }
                .mapError { .fetchError($0) }
            then(mappedResult)
        }
    }
    
}
