/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.networking

import br.com.zup.beagle.setup.BeagleEnvironment
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.mockkObject
import io.mockk.unmockkObject
import org.junit.After
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue

class HttpClientFactoryTest {

    @InjectMockKs
    private lateinit var httpClientFactory: HttpClientFactory

    @MockK
    private lateinit var networkingDispatcher: HttpClient

    @Before
    fun setup() {
        MockKAnnotations.init(this)

        mockkObject(BeagleEnvironment)
        every { BeagleEnvironment.beagleSdk.httpClient } returns null
    }

    @After
    fun after() {
        unmockkObject(BeagleEnvironment)
    }

    @Test
    fun test_make_should_return_default_dispatcher() {
        val response = httpClientFactory.make()
        assertTrue { response is HttpClientDefault }
    }

    @Test
    fun test_make_should_return_custom_dispatcher() {
        // Given
        every { BeagleEnvironment.beagleSdk.httpClient } returns networkingDispatcher

        // When
        val actual = httpClientFactory.make()

        // Then
        assertEquals(networkingDispatcher, actual)
    }
}