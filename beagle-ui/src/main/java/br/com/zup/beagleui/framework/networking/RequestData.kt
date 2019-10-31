package br.com.zup.beagleui.framework.networking

data class RequestData(
    val url: String,
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