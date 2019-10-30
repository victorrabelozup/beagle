package br.com.zup.beagleui.framework.networking

import br.com.zup.beagleui.framework.base.CoroutineDispatchers
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.net.HttpURLConnection

typealias OnSuccess = (responseData: ResponseData) -> Unit
typealias OnError = (throwable: Throwable) -> Unit

internal class HttpClientDefault(
    private val urlFactory: URLFactory
) : HttpClient, CoroutineScope {

    private val job = Job()
    override val coroutineContext = job + Dispatchers.Main

    override fun execute(
        request: RequestData,
        onSuccess: OnSuccess,
        onError: OnError
    ): RequestCall {
        require(!getOrDeleteOrHeadHasData(request)) { "${request.method} does not support request data" }

        launch(CoroutineDispatchers.Main) {
            doHttpRequest(request, onSuccess, onError)
        }

        return object: RequestCall {
            override fun cancel() {
                this@HttpClientDefault.cancel()
            }
        }
    }

    private fun getOrDeleteOrHeadHasData(request: RequestData): Boolean {
        return (request.method == HttpMethod.GET ||
                request.method == HttpMethod.DELETE ||
                request.method == HttpMethod.HEAD) &&
                request.data != null
    }

    private suspend fun doHttpRequest(
        request: RequestData,
        onSuccess: OnSuccess,
        onError: OnError
    ) = withContext(CoroutineDispatchers.IO) {
        val urlConnection = urlFactory.make(request.url).openConnection() as HttpURLConnection

        request.headers.forEach {
            urlConnection.setRequestProperty(it.key, it.value)
        }

        addRequestMethod(urlConnection, request.method)

        if (request.data != null) {
            setRequestBody(urlConnection, request.data)
        }

        try {
            onSuccess(createResponseData(urlConnection))
        } catch (e: Throwable) {
            onError(e)
        } finally {
            urlConnection.disconnect()
        }
    }

    private fun addRequestMethod(urlConnection: HttpURLConnection, method: HttpMethod) {
        val methodValue = method.toString()

        if (method == HttpMethod.PATCH || method ==  HttpMethod.HEAD) {
            urlConnection.setRequestProperty("X-HTTP-Method-Override", methodValue)
            urlConnection.requestMethod = "POST"
        } else {
            urlConnection.requestMethod = methodValue
        }
    }

    private fun setRequestBody(urlConnection: HttpURLConnection, data: String) {
        urlConnection.outputStream.write(data.toByteArray())
        urlConnection.setRequestProperty("Content-Length", data.length.toString())
    }

    private fun createResponseData(urlConnection: HttpURLConnection): ResponseData {
        val byteArray = urlConnection.inputStream.readBytes()

        return ResponseData(
            statusCode = urlConnection.responseCode,
            headers = urlConnection.headerFields.map {
                Pair(it.key, it.value.toString())
            }.toMap(),
            data = byteArray
        )
    }
}