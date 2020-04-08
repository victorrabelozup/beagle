/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

public struct Appearance: Decodable {
    
    // MARK: - Public Properties
    let backgroundColor: String?
    let cornerRadius: CornerRadius?
    
    // MARK: - Initialization
    
    public init(
        backgroundColor: String? = nil,
        cornerRadius: CornerRadius? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
    }
}

public struct CornerRadius: Decodable {
    let radius: Double
    
    public init(
        radius: Double
    ) {
        self.radius = radius
    }
}
