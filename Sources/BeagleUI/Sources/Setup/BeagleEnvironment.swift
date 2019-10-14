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
    // MARK: - Singleton
    static var shared: BeagleEnvironmentProtocol { get }
    // MARK: - Initialization
    static func initialize(appName: String, decoder: WidgetDecoder?)
    // MARK: - Public Functions
    func registerCustomWidgets<T: WidgetEntity>(_ items: [WidgetRegisterItem<T>])
}

final class BeagleEnvironment: BeagleEnvironmentProtocol {
    
    // MARK: - Dependencies
    
    private let _decoder: WidgetDecoding
    
    // MARK: - Public Properties
    
    var decoder: WidgetDecoding { _decoder }
    
    // MARK: - Singleton
    
    private static var _shared: BeagleEnvironment?
    static var shared: BeagleEnvironmentProtocol {
        guard let shared = BeagleEnvironment._shared else {
            fatalError("BeagleEnvironment was not initialized, check that!")
        }
        return shared
    }
    
    // MARK: - Initialization
    
    private init(decoder: WidgetDecoding) {
        self._decoder = decoder
    }
    
    // MARK: - Public Functions
    
    static func initialize(appName: String, decoder: WidgetDecoder?) {
        let decoderInstance = decoder ?? WidgetDecoder(namespace: appName)
        _shared = BeagleEnvironment(decoder: decoderInstance)
    }
    
    func registerCustomWidgets<T: WidgetEntity>(_ items: [WidgetRegisterItem<T>]) {
//        items.forEach {
//
//        }
//        decoder.register(<#T##type: WidgetEntity.Protocol##WidgetEntity.Protocol#>, for: <#T##String#>)
    }
    
}

public struct WidgetRegisterItem<EntityType: WidgetEntity> {
    
    let entity: Entity<EntityType>
    let view: ViewBuilderPair
    
    public struct Entity<T: WidgetEntity> {
        let typeName: String
        let type: T.Type
    }
    
    public struct ViewBuilderPair {
        let widgetType: Widget.Type
        let viewRenderer: WidgetViewRenderer
    }
    
}
