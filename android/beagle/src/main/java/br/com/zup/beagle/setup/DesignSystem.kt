/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.setup

import androidx.annotation.DrawableRes
import androidx.annotation.StyleRes

interface DesignSystem {
    @DrawableRes fun image(name: String): Int
    @StyleRes fun theme(): Int
    @StyleRes fun textAppearance(name: String): Int
    @StyleRes fun buttonStyle(name: String): Int
    @StyleRes fun toolbarStyle(name: String): Int
    @StyleRes fun tabBarStyle(name: String): Int?
}