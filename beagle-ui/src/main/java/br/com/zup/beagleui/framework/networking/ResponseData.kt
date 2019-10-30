package br.com.zup.beagleui.framework.networking

data class ResponseData(
    val statusCode: Int,
    val headers: Map<String, String> = mapOf(),
    val data: ByteArray
)