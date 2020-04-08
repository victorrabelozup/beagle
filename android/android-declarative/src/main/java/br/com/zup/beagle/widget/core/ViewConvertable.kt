/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.widget.core

import android.content.Context
import android.view.View
import br.com.zup.beagle.core.ServerDrivenComponent

interface ViewConvertable : ServerDrivenComponent {
    fun toView(context: Context): View
}