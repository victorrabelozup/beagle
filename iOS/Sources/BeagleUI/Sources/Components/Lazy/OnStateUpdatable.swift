/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/// Protocol to make an `UIView` present a lazy loaded `Component`.
/// Implementing this protocol the `onUpdateState` method will
/// be called instead of building the component.
public protocol OnStateUpdatable {
    func onUpdateState(component: ServerDrivenComponent) -> Bool
}
