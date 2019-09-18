//
//  WidgetEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Used as a markup interface for the API representation of Widgets
public protocol WidgetEntity: Codable {}

//extension WidgetEntity where Self == WidgetEntityContainer { // Not working, still in tests
//
//    func convert<T>(_ containerConverter: (WidgetEntity) throws -> T) throws -> T {
//
//        guard let content = self.content else {
//            throw NSError()
//        }
//
//        let contentEntity = content as WidgetEntity
//
//        do {
//            return try containerConverter(contentEntity)
//        } catch {
//            throw error
//        }
//
//    }
//
//}
