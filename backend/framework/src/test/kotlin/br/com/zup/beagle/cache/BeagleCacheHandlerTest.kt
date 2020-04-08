/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.cache

import br.com.zup.beagle.serialization.jackson.BeagleSerializationUtil
import br.com.zup.beagle.widget.ui.Button
import com.google.common.hash.Hashing
import io.mockk.every
import io.mockk.mockk
import io.mockk.verifySequence
import org.junit.jupiter.api.Test
import java.net.HttpURLConnection
import java.nio.charset.Charset
import kotlin.test.assertEquals
import kotlin.test.assertFalse
import kotlin.test.assertTrue

internal class BeagleCacheHandlerTest {

    private val excludedEndpoints = listOf("/ima*")

    companion object {
        private const val HOME_ENDPOINT = "/home"
        private const val IMAGE_ENDPOINT = "/image"

        private val BUTTON_JSON = BeagleSerializationUtil.beagleObjectMapper().writeValueAsString(Button("test"))
        private val BUTTON_JSON_HASH = Hashing.sha512().hashString(BUTTON_JSON, Charset.defaultCharset()).toString()
    }

    @Test
    fun cacheHandler_should_return_true_for_checkEndpointForExcludedPatterns() {
        assertTrue {
            BeagleCacheHandler(excludedEndpoints).isEndpointInExcludedPatterns(IMAGE_ENDPOINT)
        }
    }

    @Test
    fun cacheHandler_should_return_false_for_checkEndpointForExcludedPatterns() {
        assertFalse {
            BeagleCacheHandler(excludedEndpoints).isEndpointInExcludedPatterns(HOME_ENDPOINT)
        }
    }

    @Test
    fun cacheHandler_should_return_same_hash_for_button_object_when_call_generateAndAddHash() {
        assertEquals(
            BeagleCacheHandler().generateAndAddHash(HOME_ENDPOINT, BUTTON_JSON),
            BUTTON_JSON_HASH
        )
    }

    @Test
    fun cacheHandler_should_return_true_for_verifyIfHashIsUpToDate() {
        val cacheHandler = BeagleCacheHandler()
        cacheHandler.generateAndAddHash(HOME_ENDPOINT, BUTTON_JSON)
        assertTrue {
            cacheHandler.isHashUpToDate(HOME_ENDPOINT, BUTTON_JSON_HASH)
        }
    }

    @Test
    fun cacheHandler_should_return_false_for_verifyIfHashIsUpToDate() {
        val cacheHandler = BeagleCacheHandler()
        val cacheHandler2 = BeagleCacheHandler()
        cacheHandler.generateAndAddHash(HOME_ENDPOINT, BUTTON_JSON)
        assertFalse {
            cacheHandler.isHashUpToDate(HOME_ENDPOINT, "hash")
        }
        assertFalse {
            cacheHandler2.isHashUpToDate(HOME_ENDPOINT, BUTTON_JSON_HASH)
        }
    }

    @Test
    fun test_handleCache_when_excluded_endpoint() {
        testHandleCache(endpoint = IMAGE_ENDPOINT) {
            verifySequence { it.callController(Response.START) }
        }
    }

    @Test
    fun test_handleCache_when_no_previous_cache() {
        testHandleCache(endpoint = HOME_ENDPOINT, verify = this::verifySentResponse)
    }

    @Test
    fun test_handleCache_when_previous_cache_is_outdated() {
        testHandleCache(
            endpoint = HOME_ENDPOINT,
            hash = "",
            prepare = this::preparePreviousCache,
            verify = this::verifySentResponse
        )
    }

    @Test
    fun test_handleCache_when_previous_cache_is_up_to_date() {
        testHandleCache(endpoint = HOME_ENDPOINT, hash = BUTTON_JSON_HASH, prepare = this::preparePreviousCache) {
            verifySequence {
                it.addStatus(Response.START, HttpURLConnection.HTTP_NOT_MODIFIED)
                it.addHashHeader(Response.STATUS, BUTTON_JSON_HASH)
            }
        }
    }

    private fun testHandleCache(
        endpoint: String,
        hash: String? = null,
        prepare: (BeagleCacheHandler) -> Unit = {},
        verify: (RestCacheHandler<Response>) -> Unit
    ) {
        val restCache = mockk<RestCacheHandler<Response>>()
        val cacheHandler = BeagleCacheHandler(excludedEndpoints)
        val response = BUTTON_JSON

        prepare(cacheHandler)
        every { restCache.callController(any()) } returns Response.CONTROLLER
        every { restCache.addHashHeader(any(), any()) } returns Response.HEADER
        every { restCache.addStatus(any(), any()) } returns Response.STATUS
        every { restCache.getBody(any()) } returns response

        cacheHandler.handleCache(endpoint, hash, Response.START, restCache)

        verify(restCache)
    }

    private fun preparePreviousCache(handler: BeagleCacheHandler) {
        handler.generateAndAddHash(HOME_ENDPOINT, BUTTON_JSON)
    }

    private fun verifySentResponse(handler: RestCacheHandler<Response>) {
        verifySequence {
            handler.callController(Response.START)
            handler.getBody(Response.CONTROLLER)
            handler.addHashHeader(Response.CONTROLLER, BUTTON_JSON_HASH)
        }
    }

    private enum class Response { START, CONTROLLER, HEADER, STATUS }
}