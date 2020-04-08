/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

public struct FormInput: FormInputComponent {
    
    public let name: String
    public let child: ServerDrivenComponent
    public let required: Bool?
    public let validator: String?
    public let errorMessage: String?
    
    public init(
        name: String,
        required: Bool? = nil,
        validator: String? = nil,
        errorMessage: String? = nil,
        child: ServerDrivenComponent
    ) {
        self.name = name
        self.required = required
        self.validator = validator
        self.errorMessage = errorMessage
        self.child = child
    }
    
}

extension FormInput: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        childView.beagleFormElement = self
        return childView
    }
}

extension FormInput: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case required
        case validator
        case errorMessage
        case child
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.required = try container.decodeIfPresent(Bool.self, forKey: .required)
        self.validator = try container.decodeIfPresent(String.self, forKey: .validator)
        self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
        self.child = try container.decode(forKey: .child)
    }
}
