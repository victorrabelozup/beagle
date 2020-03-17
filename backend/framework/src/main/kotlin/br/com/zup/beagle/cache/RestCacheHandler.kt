package br.com.zup.beagle.cache

interface RestCacheHandler {
    fun callController()

    fun finalizeResponse() = Unit

    fun addHashHeaderToResponse(header: String)

    fun addStatusToResponse(status: Int)

    fun getResponseBody(): String
}