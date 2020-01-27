package br.com.zup.beagle.networking

data class RequestData(
    val endpoint: String? = null,
    val path: String? = null,
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