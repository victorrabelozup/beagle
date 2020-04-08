/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

@file:JvmName("BeagleUtils")

package br.com.zup.beagle.utils

import br.com.zup.beagle.view.BeagleActivity
import br.com.zup.beagle.view.BeagleNavigator

fun String.toAndroidId(): Int {
    return this.hashCode()
}

internal fun BeagleActivity.configureSupportActionBar() {
    val toolbar = this.getToolbar()
    if (this.supportActionBar == null) {
        this.setSupportActionBar(toolbar)
        this.supportActionBar?.hide()
    }
    toolbar.setNavigationOnClickListener {
        BeagleNavigator.pop(this)
    }
}