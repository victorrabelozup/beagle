//
//  WidgetViewRendererRegister.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 04/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

//protocol WidgetViewRendererRegisterProtocol {
//    func register<T: WidgetViewRenderer>(_ rendererType: T.Type)
//    func dequeueRenderer<T: Widget, R: WidgetViewRenderer>(for widget: T) -> R
//}
//
//public final class WidgetViewRendererRegister: WidgetViewRendererRegisterProtocol {
//
//    // MARK: - Singleton
//    
//    public static let shared = WidgetViewRendererRegister()
//
//    // MARK: - Initialization
//
//    private init() {}
//
//    // MARK: - Properties
//
//    private var register = [String: WidgetViewRenderer.Type]()
//
//    // MARK: - Public Methods
//
//    public func register<T>(_ rendererType: T.Type) where T : WidgetViewRenderer {
//        let typeName = String(describing: rendererType)
//        register[typeName] = rendererType
//    }
//
//    public func dequeueRenderer<T, R>(for widget: T) -> R where T : Widget, R : WidgetViewRenderer {
//
//    }
//
//    func reset() {
//        register.removeAll()
//    }
//
//}
