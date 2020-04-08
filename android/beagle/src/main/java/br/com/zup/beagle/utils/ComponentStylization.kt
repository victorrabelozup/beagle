/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.utils

import android.view.View
import br.com.zup.beagle.core.IdentifierComponent
import br.com.zup.beagle.core.ServerDrivenComponent

class ComponentStylization<T : ServerDrivenComponent>(
    private val accessibilitySetup: AccessibilitySetup = AccessibilitySetup()
) {
    fun apply(view: View, component: T) {
        view.applyAppearance(component)
        (component as? IdentifierComponent)?.id?.let {
            view.id = it.toAndroidId()
        }
        accessibilitySetup.applyAccessibility(view, component)
    }
}
