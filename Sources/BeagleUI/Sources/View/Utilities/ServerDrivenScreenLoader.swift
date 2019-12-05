//
//  ServerDrivenScreenLoader.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 17/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public enum ServerDrivenScreenLoaderError: Error {
    case fetchError(ServerDrivenWidgetFetcherError)
}

public protocol ServerDrivenScreenLoader {
    func loadScreen(from url: String, context: BeagleContext, completion: @escaping (Result<UIView, ServerDrivenScreenLoaderError>) -> Void)
    func submitForm(action: String, method: Form.MethodType, values: [String: String], completion: @escaping (Result<Action, ServerDrivenWidgetFetcherError>) -> Void)
    func loadWidget(from url: String, completion: @escaping (Result<Widget, ServerDrivenWidgetFetcherError>) -> Void)
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
    
    public func loadScreen(from url: String, context: BeagleContext, completion: @escaping (Result<UIView, ServerDrivenScreenLoaderError>) -> Void) {
        widgetFetcher.fetchWidget(from: url) {
            let mappedResult: Result<UIView, ServerDrivenScreenLoaderError> = $0
                .map { self.viewBuilder.buildFromRootWidget($0, context: context) }
                .mapError { .fetchError($0) }
            completion(mappedResult)
        }
    }
    
    public func submitForm(action: String, method: Form.MethodType, values: [String: String], completion: @escaping (Result<Action, ServerDrivenWidgetFetcherError>) -> Void) {
        widgetFetcher.submitForm(action: action, method: method, values: values, completion: completion)
    }
    
    public func loadWidget(from url: String, completion: @escaping (Result<Widget, ServerDrivenWidgetFetcherError>) -> Void) {
        widgetFetcher.fetchWidget(from: url, completion: completion)
    }
    
}
