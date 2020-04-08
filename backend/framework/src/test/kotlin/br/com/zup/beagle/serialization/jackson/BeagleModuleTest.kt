/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.serialization.jackson

import org.junit.jupiter.api.Test
import kotlin.reflect.KProperty1
import kotlin.reflect.KVisibility
import kotlin.reflect.full.memberProperties
import kotlin.reflect.jvm.isAccessible
import kotlin.test.assertTrue

internal class BeagleModuleTest {
    @Test
    fun beagleModule_should_be_initialized_with_BeagleSerializerModifier() {
        assertTrue {
            BeagleModule::class.memberProperties
                .find { it.name == "_serializerModifier" }
                ?.run {
                    this.isAccessible = true
                    this.get(BeagleModule) is BeagleSerializerModifier
                }!!
        }
    }
}