/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.networking

import io.mockk.mockk
import org.junit.Test

import org.junit.Assert.*

class ResponseDataTest {

    @Test
    fun equals_should_compare_two_objects_that_have_equals_data() {
        val responseData1 = ResponseData(0, byteArrayOf())
        val responseData2 = ResponseData(0, byteArrayOf())

        assertTrue(responseData1 == responseData2)
    }

    @Test
    fun equals_should_compare_two_objects_that_have_different_status_code() {
        val responseData1 = ResponseData(0, byteArrayOf())
        val responseData2 = ResponseData(1, byteArrayOf())

        assertFalse(responseData1 == responseData2)
    }

    @Test
    fun equals_should_compare_two_objects_that_have_different_headers() {
        val responseData1 = ResponseData(0, byteArrayOf(), headers = mapOf(Pair("", "")))
        val responseData2 = ResponseData(0, byteArrayOf(), headers = mapOf())

        assertFalse(responseData1 == responseData2)
    }

    @Test
    fun equals_should_compare_two_objects_that_have_different_bytes() {
        val responseData1 = ResponseData(0, byteArrayOf(0x0))
        val responseData2 = ResponseData(0, byteArrayOf(0x0, 0x10))

        assertFalse(responseData1 == responseData2)
    }

    @Test
    fun equals_should_compare_two_objects_of_same_instance() {
        val responseData = ResponseData(0, byteArrayOf())

        assertTrue(responseData == responseData)
    }

    @Test
    fun equals_should_compare_two_different_classes() {
        val responseData = ResponseData(0, byteArrayOf())
        val otherClass = mockk<RequestData>()

        assertFalse(responseData.equals(otherClass))
    }

    @Test
    fun hashCode1() {
        val responseData1 = ResponseData(0, byteArrayOf())
        val responseData2 = ResponseData(0, byteArrayOf())

        assertEquals(responseData1.hashCode(), responseData2.hashCode())
    }
}