/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.action

import br.com.zup.beagle.widget.layout.Screen

enum class NavigationType {
    OPEN_DEEP_LINK,
    ADD_VIEW,
    SWAP_VIEW,
    FINISH_VIEW,
    POP_VIEW,
    POP_TO_VIEW,
    PRESENT_VIEW
}

data class Navigate(
    val type: NavigationType,
    val shouldPrefetch: Boolean = false,
    val path: String? = null,
    val data: Map<String, String>? = null,
    val screen: Screen? = null
) : Action