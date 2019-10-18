package br.com.zup.beagleui.framework.config.networking

import java.net.HttpURLConnection

typealias OnSuccess = (responseData: ResponseData) -> Unit
typealias OnError = (throwable: Throwable) -> Unit

internal class URLRequestDispatchingDefault(private val urlFactory: URLFactory) :
    URLRequestDispatching {
    override fun execute(
        request: RequestData,
        onSuccess: OnSuccess,
        onError: OnError
    ): RequestCall? {
        //TODO handle other http methods
        return if (request.method == HttpMethod.GET) {
            requestGetCall(request, onSuccess, onError)
        } else {
            onError(IllegalArgumentException("Method ${request.method} not supported yet"))
            null
        }
    }

    private fun requestGetCall(
        request: RequestData,
        onSuccess: OnSuccess,
        onError: OnError
    ): RequestCall {
        val urlConnection = urlFactory.make(url = request.url).openConnection() as HttpURLConnection
        //Adding headers
        request.headers.forEach {
            urlConnection.setRequestProperty(it.key, it.value)
        }

        try {
            val byteArray = urlConnection.inputStream.readBytes()
            onSuccess(ResponseData(data = byteArray))
        } catch (e: Throwable) {
            onError(e)
        } finally {
            urlConnection.disconnect()
        }

        return object : RequestCall {
            override fun cancel() {
                //TODO understand how to cancel the request
            }
        }
    }
}