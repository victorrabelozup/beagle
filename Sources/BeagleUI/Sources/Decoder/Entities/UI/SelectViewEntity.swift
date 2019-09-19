//
//  SelectViewEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `SelectView`
struct SelectViewEntity: WidgetEntity {
    let rows: [WidgetEntityContainer]?
    let remoteDataSource: String?
    let loadingState: WidgetEntityContainer?
}
extension SelectViewEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        let rows = self.rows?.compactMap { try? $0.content?.mapToWidget() }
        let loadingState = try? self.loadingState?.content?.mapToWidget()
        return SelectView(rows: rows, remoteDataSource: remoteDataSource, loadingState: loadingState)
    }
}
