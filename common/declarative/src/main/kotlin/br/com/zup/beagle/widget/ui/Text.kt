/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.widget.Widget

data class Text(
    val text: String,
    val style: String? = null,
    val textColor: String? = null,
    val alignment: TextAlignment? = null
) : Widget()

enum class TextAlignment {
    LEFT,
    CENTER,
    RIGHT
}