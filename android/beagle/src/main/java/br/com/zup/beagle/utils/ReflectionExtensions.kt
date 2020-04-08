/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.utils

import java.lang.reflect.Field
import java.lang.reflect.Modifier

private const val MODIFIERS = "modifiers"
internal fun Field.setNotFinalAndAccessible() {
    try {
        this.isAccessible = true

        val modifiersField = this.javaClass.getDeclaredField(MODIFIERS)
        modifiersField.isAccessible = true
        modifiersField.setInt(this, this.modifiers and Modifier.FINAL.inv())
    } catch (e: Exception) {
        //ignored
        e.printStackTrace()
    }
}