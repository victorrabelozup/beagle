/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.cache

import br.com.zup.beagle.serialization.jackson.BeagleSerializationUtil
import br.com.zup.beagle.widget.ui.Button
import com.google.common.hash.Hashing
import io.mockk.every
import io.mockk.mockk
import io.mockk.verifyAll
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
            verifySequence {
                it.callController()
                it.finalizeResponse()
            }
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
            verifyAll {
                it.addHashHeaderToResponse(BUTTON_JSON_HASH)
                it.addStatusToResponse(HttpURLConnection.HTTP_NOT_MODIFIED)
            }
        }
    }

    private fun testHandleCache(
        endpoint: String,
        hash: String? = null,
        prepare: (BeagleCacheHandler) -> Unit = {},
        verify: (RestCacheHandler) -> Unit
    ) {
        val restCache = mockk<RestCacheHandler>(relaxUnitFun = true)
        val cacheHandler = BeagleCacheHandler(excludedEndpoints)
        val response = BUTTON_JSON

        prepare(cacheHandler)
        every { restCache.getResponseBody() } returns response

        cacheHandler.handleCache(endpoint, hash, restCache)

        verify(restCache)
    }

    private fun preparePreviousCache(handler: BeagleCacheHandler) {
        handler.generateAndAddHash(HOME_ENDPOINT, BUTTON_JSON)
    }

    private fun verifySentResponse(handler: RestCacheHandler) {
        verifySequence {
            handler.callController()
            handler.getResponseBody()
            handler.addHashHeaderToResponse(BUTTON_JSON_HASH)
            handler.finalizeResponse()
        }
    }
}