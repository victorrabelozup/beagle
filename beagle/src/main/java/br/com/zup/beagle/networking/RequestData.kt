package br.com.zup.beagle.networking

import java.net.URI

data class RequestData(
    val uri: URI,
    val method: HttpMethod = HttpMethod.GET,
    val headers: Map<String, String> = mapOf(),
    val body: String? = null
)

enum class HttpMethod {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD,
    PATCH
}