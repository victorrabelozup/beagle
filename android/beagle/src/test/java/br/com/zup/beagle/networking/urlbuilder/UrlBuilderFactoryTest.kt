/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.networking.urlbuilder

import br.com.zup.beagle.BaseTest
import br.com.zup.beagle.networking.urlbuilder.UrlBuilder
import br.com.zup.beagle.networking.urlbuilder.UrlBuilderDefault
import br.com.zup.beagle.networking.urlbuilder.UrlBuilderFactory
import br.com.zup.beagle.setup.BeagleEnvironment
import io.mockk.every
import io.mockk.impl.annotations.MockK
import org.junit.Test
import io.mockk.impl.annotations.InjectMockKs
import kotlin.test.assertEquals
import kotlin.test.assertTrue

class UrlBuilderFactoryTest : BaseTest() {

    @InjectMockKs
    private lateinit var urlBuilderFactory: UrlBuilderFactory

    @MockK
    private lateinit var urlBuilder: UrlBuilder

    @Test
    fun make_should_return_default_builder() {
        // Given
        every { BeagleEnvironment.beagleSdk.urlBuilder } returns null

        // When
        val builder = urlBuilderFactory.make()

        // Then
        assertTrue { builder is UrlBuilderDefault }
    }

    @Test
    fun make_should_return_custom_dispatcher() {
        // Given
        every { BeagleEnvironment.beagleSdk.urlBuilder } returns urlBuilder

        // When
        val actual = urlBuilderFactory.make()

        // Then
        assertEquals(urlBuilder, actual)
    }
}