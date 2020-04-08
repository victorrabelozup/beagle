/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.widget.form

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.core.LayoutComponent
import br.com.zup.beagle.core.ServerDrivenComponent

enum class FormMethodType {
    GET,
    POST,
    PUT,
    DELETE
}

data class Form (
    val action: Action,
    val child: ServerDrivenComponent
) : ServerDrivenComponent, LayoutComponent

data class FormRemoteAction(
    val path: String,
    val method: FormMethodType
) : Action {
    override fun toString() = "FormRemoteAction: $path / ${method.name}"
}

