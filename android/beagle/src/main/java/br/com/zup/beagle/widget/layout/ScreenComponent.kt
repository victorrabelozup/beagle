/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.AppearanceComponent
import br.com.zup.beagle.core.LayoutComponent
import br.com.zup.beagle.core.ServerDrivenComponent

internal data class ScreenComponent(
    val identifier: String? = null,
    val navigationBar: NavigationBar? = null,
    val child: ServerDrivenComponent
) : AppearanceComponent, LayoutComponent {

    override var appearance: Appearance? = null
        private set

    fun applyAppearance(appearance: Appearance): ScreenComponent {
        this.appearance = appearance
        return this
    }
}
