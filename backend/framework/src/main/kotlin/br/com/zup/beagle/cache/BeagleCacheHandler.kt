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

import com.google.common.hash.Hashing
import java.net.HttpURLConnection
import java.nio.charset.Charset
import java.util.regex.Pattern

class BeagleCacheHandler(excludeEndpoints: List<String> = listOf()) {
    companion object {
        const val CACHE_HEADER = "beagle-hash"
    }

    private val endpointHashMap = mutableMapOf<String, String>()
    private val excludePatterns = excludeEndpoints.filter { it.isNotEmpty() }.map(Pattern::compile)

    private fun generateHashForJson(json: String) =
        Hashing.sha512().hashString(json, Charset.defaultCharset()).toString()

    internal fun isEndpointInExcludedPatterns(endpoint: String) =
        this.excludePatterns.any { it.matcher(endpoint).find() }

    internal fun isHashUpToDate(endpoint: String, hash: String) = this.endpointHashMap[endpoint] == hash

    internal fun generateAndAddHash(endpoint: String, json: String) =
        this.endpointHashMap.computeIfAbsent(endpoint) { generateHashForJson(json) }

    fun handleCache(endpoint: String, receivedHash: String?, restHandler: RestCacheHandler) =
        when {
            isEndpointInExcludedPatterns(endpoint) -> {
                restHandler.callController()
                restHandler.finalizeResponse()
            }
            receivedHash != null && isHashUpToDate(endpoint, receivedHash) -> {
                restHandler.addStatusToResponse(HttpURLConnection.HTTP_NOT_MODIFIED)
                restHandler.addHashHeaderToResponse(receivedHash)
            }
            else -> {
                restHandler.callController()
                restHandler.addHashHeaderToResponse(generateAndAddHash(endpoint, restHandler.getResponseBody()))
                restHandler.finalizeResponse()
            }
        }
}