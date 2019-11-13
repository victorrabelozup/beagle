//
//  BeagleEnvironment.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation
import Networking

protocol BeagleEnvironmentProtocol {
    // MARK: - Properties
    var decoder: WidgetDecoding { get }
    var networkingDispatcher: URLRequestDispatching { get }
    var customWidgetsProvider: CustomWidgetsRendererProviderDequeuing { get }
    var appBundle: Bundle { get }
    var applicationTheme: Theme { get }
    // MARK: - Singleton
    static var shared: BeagleEnvironmentProtocol { get }
    // MARK: - Initialization
    static func initialize(
        appName: String,
        decoder: WidgetDecoding,
        networkingDispatcher: URLRequestDispatching,
        customWidgetsRendererProviderRegister: CustomWidgetsRendererProviderRegistering & CustomWidgetsRendererProviderDequeuing,
        appBundle: Bundle,
        applicationTheme: Theme
    )
    static func initialize(appName: String, networkingDispatcher: URLRequestDispatching?, appBundle: Bundle?, applicationTheme: Theme?)
    // MARK: - Public Functions
    func registerCustomWidget<E: WidgetConvertibleEntity, W: Widget>(_ item: WidgetRegisterItem<E, W>)
    
    func configureTheme(_ theme: Theme)
}

final class BeagleEnvironment: BeagleEnvironmentProtocol {
    // MARK: - Dependencies
    
    private let _decoder: WidgetDecoding
    private let _networkingDispatcher: URLRequestDispatching
    private let customWidgetsRendererProviderRegister: CustomWidgetsRendererProviderRegistering & CustomWidgetsRendererProviderDequeuing
    private let _appBundle: Bundle
    private var _applicationTheme: Theme
    
    // MARK: - Public Properties
    
    var decoder: WidgetDecoding { _decoder }
    var networkingDispatcher: URLRequestDispatching { _networkingDispatcher }
    var customWidgetsProvider: CustomWidgetsRendererProviderDequeuing { customWidgetsRendererProviderRegister }
    var appBundle: Bundle { _appBundle }
    var applicationTheme: Theme { _applicationTheme }
    
    // MARK: - Singleton
    
    private static var _shared: BeagleEnvironment?
    static var shared: BeagleEnvironmentProtocol {
        guard let shared = BeagleEnvironment._shared else {
            fatalError("BeagleEnvironment was not initialized, check that!")
        }
        return shared
    }
    
    // MARK: - Initialization
    
    private init(
        decoder: WidgetDecoding,
        networkingDispatcher: URLRequestDispatching,
        customWidgetsRendererProviderRegister: CustomWidgetsRendererProviderRegistering & CustomWidgetsRendererProviderDequeuing,
        appBundle: Bundle,
        applicationTheme: Theme
    ) {
        self._decoder = decoder
        self._networkingDispatcher = networkingDispatcher
        self.customWidgetsRendererProviderRegister = customWidgetsRendererProviderRegister
        self._appBundle = appBundle
        self._applicationTheme = applicationTheme
    }
    
    // MARK: - Public Functions
    
    static func initialize(
        appName: String,
        decoder: WidgetDecoding,
        networkingDispatcher: URLRequestDispatching,
        customWidgetsRendererProviderRegister: CustomWidgetsRendererProviderRegistering & CustomWidgetsRendererProviderDequeuing = CustomWidgetsRendererProviderRegister(),
        appBundle: Bundle,
        applicationTheme: Theme
    ) {
        let decoderInstance = decoder
        _shared = BeagleEnvironment(
            decoder: decoderInstance,
            networkingDispatcher: networkingDispatcher,
            customWidgetsRendererProviderRegister: customWidgetsRendererProviderRegister,
            appBundle: appBundle,
            applicationTheme: applicationTheme
        )
    }
    
    static func initialize(appName: String, networkingDispatcher: URLRequestDispatching? = nil, appBundle: Bundle? = nil, applicationTheme: Theme? = nil) {
        let decoder = WidgetDecoder(namespace: appName)
        let dispatcher = networkingDispatcher ?? URLSessionDispatcher()
        initialize(appName: appName, decoder: decoder, networkingDispatcher: dispatcher, appBundle: appBundle ?? Bundle.main, applicationTheme: applicationTheme ?? AppTheme(styles: [:]))
    }
    
    func registerCustomWidget<E: WidgetConvertibleEntity, W: Widget>(_ item: WidgetRegisterItem<E, W>) {
        decoder.register(item.entity.type, for: item.entity.typeName)
        customWidgetsRendererProviderRegister.registerRenderer(item.view.viewRenderer, for: item.view.widgetType)
    }
    
    func configureTheme(_ theme: Theme) {
        _applicationTheme = theme
    }
}
