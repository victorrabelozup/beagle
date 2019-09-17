//
//  ListView.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ListView: Widget {
    let rows: [Widget]?
    let remoteDataSource: String?
    let loadingState: Widget?
    let direction: ListDirection = .vertical
}

enum ListDirection {
    case vertical
    case horizontal
}
