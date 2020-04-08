/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.core.ServerDrivenComponent

data class TabView(
    val tabItems: List<TabItem>,
    val style: String? = null
) : ServerDrivenComponent

data class TabItem(
    val title: String? = null,
    val content: ServerDrivenComponent,
    val icon: String? = null
)