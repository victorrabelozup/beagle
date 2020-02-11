//
//  SpacerEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct SpacerEntity: ComponentEntity {
    let size: Double
}

extension SpacerEntity: ComponentConvertible {
    func mapToComponent() throws -> ServerDrivenComponent {
        return Spacer(size)
    }
}
