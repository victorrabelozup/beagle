/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

public protocol AppearanceComponent: ServerDrivenComponent {
    var appearance: Appearance? { get }
}

public protocol FlexComponent: ServerDrivenComponent {
    var flex: Flex? { get }
}

public protocol AccessibilityComponent: ServerDrivenComponent {
    var accessibility: Accessibility? { get }
}

public protocol IdentifiableComponent: ServerDrivenComponent {
    var id: String? { get }
}

public protocol Widget: AppearanceComponent, FlexComponent, AccessibilityComponent, IdentifiableComponent { }
