/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
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
        this.endpointHashMap.computeIfAbsent(endpoint) { this.generateHashForJson(json) }

    fun <T> handleCache(endpoint: String, receivedHash: String?, initialResponse: T, restHandler: RestCacheHandler<T>) =
        when {
            this.isEndpointInExcludedPatterns(endpoint) -> restHandler.callController(initialResponse)
            receivedHash != null && this.isHashUpToDate(endpoint, receivedHash) ->
                restHandler.addStatus(initialResponse, HttpURLConnection.HTTP_NOT_MODIFIED)
                    .let { restHandler.addHashHeader(it, receivedHash) }
            else ->
                restHandler.callController(initialResponse)
                    .let { restHandler.addHashHeader(it, this.generateAndAddHash(endpoint, restHandler.getBody(it))) }
        }
}