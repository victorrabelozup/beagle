/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.utils

import org.junit.Test

import org.junit.Assert.assertEquals

class BeagleExtensionsKtTest {

    @Test
    fun toAndroidId_should_return_3546_when_value_is_oi() {
        // Given
        val myId = "oi"

        // When
        val result = myId.toAndroidId()

        // Then
        assertEquals(3546, result)
    }

    @Test
    fun toAndroidId_should_return_3366_when_value_is_OI() {
        // Given
        val myId = "OI"

        // When
        val result = myId.toAndroidId()

        // Then
        assertEquals(2522, result)
    }

    @Test
    fun toAndroidId_should_return_3366_when_value_is_io() {
        // Given
        val myId = "io"

        // When
        val result = myId.toAndroidId()

        // Then
        assertEquals(3366, result)
    }
}