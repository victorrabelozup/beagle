package br.com.zup.beagle.mockdata

import br.com.zup.beagle.data.serializer.makeButtonJson
import br.com.zup.beagle.networking.HttpMethod
import br.com.zup.beagle.networking.RequestData
import br.com.zup.beagle.networking.ResponseData
import br.com.zup.beagle.testutil.RandomData
import java.net.URI

fun makeResponseData() = ResponseData(
    statusCode = RandomData.int(),
    data = RandomData.string().toByteArray(),
    headers = mapOf("request-type" to "application/json")
)

fun makeRequestData() = RequestData(
    uri = URI(RandomData.string()),
    method =  HttpMethod.GET,
    headers = mapOf("Authorization" to RandomData.string()),
    body = makeButtonJson()
)