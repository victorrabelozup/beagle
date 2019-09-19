//
//  WidgetConvertible.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Serves as a gateway between APIEntities and UIModels
protocol WidgetConvertible {
    func mapToWidget() throws -> Widget
}

/// Describes the possible errors when mapping to a UIModel (Widget)
///
/// - emptyContentForContainerOfType: some container has an empty content, when it shouldn't
enum WidgetConvertibleError: Error {
    
    case emptyContentForContainerOfType(String)
    
    var localizedDescription: String {
        switch self {
        case let .emptyContentForContainerOfType(type):
            return "Empty content for container of type = \(type)"
        }
    }
}
