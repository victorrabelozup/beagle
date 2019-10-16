//
//  BeagleEnvironment.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

protocol BeagleEnvironmentProtocol {
    // MARK: - Properties
    var decoder: WidgetDecoding { get }
    var customWidgetsProvider: CustomWidgetsRendererProviderDequeuing { get }
    // MARK: - Singleton
    static var shared: BeagleEnvironmentProtocol { get }
    // MARK: - Initialization
    static func initialize(
        appName: String,
        decoder: WidgetDecoding,
        customWidgetsRendererProviderRegister: CustomWidgetsRendererProviderRegistering & CustomWidgetsRendererProviderDequeuing
    )
    static func initialize(appName: String)
    // MARK: - Public Functions
    func registerCustomWidget<E: WidgetConvertibleEntity, W: Widget>(_ item: WidgetRegisterItem<E, W>)
}

final class BeagleEnvironment: BeagleEnvironmentProtocol {
    
    // MARK: - Dependencies
    
    private let _decoder: WidgetDecoding
    let customWidgetsRendererProviderRegister: CustomWidgetsRendererProviderRegistering & CustomWidgetsRendererProviderDequeuing
    
    // MARK: - Public Properties
    
    var decoder: WidgetDecoding { _decoder }
    var customWidgetsProvider: CustomWidgetsRendererProviderDequeuing { customWidgetsRendererProviderRegister }
    
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
        customWidgetsRendererProviderRegister: CustomWidgetsRendererProviderRegistering & CustomWidgetsRendererProviderDequeuing
    ) {
        self._decoder = decoder
        self.customWidgetsRendererProviderRegister = customWidgetsRendererProviderRegister
    }
    
    // MARK: - Public Functions
    
    static func initialize(
        appName: String,
        decoder: WidgetDecoding,
        customWidgetsRendererProviderRegister: CustomWidgetsRendererProviderRegistering & CustomWidgetsRendererProviderDequeuing = CustomWidgetsRendererProviderRegister()
    ) {
        let decoderInstance = decoder
        _shared = BeagleEnvironment(
            decoder: decoderInstance,
            customWidgetsRendererProviderRegister: customWidgetsRendererProviderRegister
        )
    }
    
    public static func initialize(appName: String) {
        initialize(appName: appName, decoder: WidgetDecoder(namespace: appName))
    }
    
    func registerCustomWidget<E: WidgetConvertibleEntity, W: Widget>(_ item: WidgetRegisterItem<E, W>) {
        decoder.register(item.entity.type, for: item.entity.typeName)
        customWidgetsRendererProviderRegister.registerRenderer(item.view.viewRenderer, for: item.view.widgetType)
    }
    
}
