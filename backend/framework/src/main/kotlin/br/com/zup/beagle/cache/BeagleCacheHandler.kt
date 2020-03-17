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