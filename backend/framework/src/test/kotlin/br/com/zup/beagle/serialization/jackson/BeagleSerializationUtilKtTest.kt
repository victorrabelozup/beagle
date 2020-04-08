/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.serialization.jackson

import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test

internal class BeagleSerializationUtilKtTest {

    @Test
    fun beagleObjectMapper_function_returns_mapper_with_beagleModule() {
        val mapper = BeagleSerializationUtil.beagleObjectMapper()
        assertTrue(mapper.registeredModuleIds.contains(BeagleModule.typeId))
    }
}