/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.networking

import br.com.zup.beagle.testutil.RandomData
import org.junit.Before

import org.junit.Test
import java.net.URI
import kotlin.test.assertEquals
import kotlin.test.assertNull
import kotlin.test.assertTrue

class RequestDataTest {

    private lateinit var requestData: RequestData

    @Before
    fun setUp() {
        requestData = RequestData(URI(RandomData.httpUrl()))
    }

    @Test
    fun requestData_should_have_method_GET_as_default() {
        assertEquals(HttpMethod.GET, requestData.method)
    }

    @Test
    fun requestData_should_have_empty_headers() {
        assertTrue(requestData.headers.isEmpty())
    }

    @Test
    fun requestData_should_have_data_null() {
        assertNull(requestData.body)
    }
}