/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.analytics.ScreenAnalytics
import br.com.zup.beagle.analytics.ScreenEvent
import br.com.zup.beagle.core.Accessibility
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.IdentifierComponent
import br.com.zup.beagle.core.ServerDrivenComponent

data class SafeArea(
    val top: Boolean? = null,
    val leading: Boolean? = null,
    val bottom: Boolean? = null,
    val trailing: Boolean? = null
)

data class NavigationBarItem(
    val text: String,
    val image: String? = null,
    val action: Action,
    val accessibility: Accessibility? = null
) : IdentifierComponent {
    override var id: String? = null
        private set

    fun setId(id: String): NavigationBarItem {
        this.id = id
        return this
    }
}

data class NavigationBar(
    val title: String,
    val showBackButton: Boolean = true,
    val style: String? = null,
    val navigationBarItems: List<NavigationBarItem>? = null,
    val backButtonAccessibility: Accessibility? = null
)

data class Screen(
    val identifier: String? = null,
    val safeArea: SafeArea? = null,
    val navigationBar: NavigationBar? = null,
    val child: ServerDrivenComponent,
    val appearance: Appearance? = null,
    override val screenAnalyticsEvent: ScreenEvent? = null
): ScreenAnalytics