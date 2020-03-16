package br.com.zup.beagle.data

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.data.cache.BeagleCacheHelper
import br.com.zup.beagle.data.serializer.BeagleSerializer
import br.com.zup.beagle.exception.BeagleException
import br.com.zup.beagle.logger.BeagleMessageLogs
import br.com.zup.beagle.networking.HttpClient
import br.com.zup.beagle.networking.HttpClientFactory
import br.com.zup.beagle.networking.HttpMethod
import br.com.zup.beagle.networking.RequestData
import br.com.zup.beagle.networking.UrlFormatter
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.utils.CoroutineDispatchers
import br.com.zup.beagle.view.ScreenMethod
import br.com.zup.beagle.view.ScreenRequest
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.withContext
import java.net.URI
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException

internal class BeagleService(
    private val serializer: BeagleSerializer = BeagleSerializer(),
    private val httpClient: HttpClient = HttpClientFactory().make(),
    private val urlFormatter: UrlFormatter = UrlFormatter()
) {

    @Throws(BeagleException::class)
    suspend fun fetchComponent(screenRequest: ScreenRequest): ServerDrivenComponent {
        return run {
            withContext(CoroutineDispatchers.Default) {
                BeagleCacheHelper.getFromCache(screenRequest.url)
            }
        } ?: run {
            val jsonResponse = fetchData(screenRequest)
            val widget = deserializeComponent(jsonResponse)
            BeagleCacheHelper.cache(screenRequest.url, widget)
        }
    }

    @Throws(BeagleException::class)
    suspend fun fetchAction(url: String): Action {
        val jsonResponse = fetchData(ScreenRequest(url))
        return deserializeAction(jsonResponse)
    }

    private suspend fun fetchData(screenRequest: ScreenRequest): String = suspendCancellableCoroutine { cont ->
        try {
            val call = httpClient.execute(request = makeRequestData(screenRequest),
                onSuccess = { response ->
                    BeagleMessageLogs.logHttpResponseData(response)
                    cont.resume(String(response.data))
                }, onError = { error ->
                    BeagleMessageLogs.logUnknownHttpError(error)
                    cont.resumeWithException(
                        BeagleException(error.message ?: genericErrorMessage(screenRequest.url), error)
                    )
                })

            cont.invokeOnCancellation {
                call.cancel()
            }
        } catch (ex: Exception) {
            BeagleMessageLogs.logUnknownHttpError(ex)
            cont.resumeWithException(BeagleException(ex.message ?: genericErrorMessage(screenRequest.url), ex))
        }
    }

    private fun makeRequestData(screenRequest: ScreenRequest): RequestData {
        val newUrl = urlFormatter.format(BeagleEnvironment.beagleSdk.config.baseUrl, screenRequest.url)
        val request = RequestData(
            uri = URI(newUrl),
            method = generateRequestDataMethod(screenRequest.method),
            headers = screenRequest.headers,
            body = screenRequest.body
        )

        BeagleMessageLogs.logHttpRequestData(request)

        return request
    }

    private fun generateRequestDataMethod(screenMethod: ScreenMethod) =
        when (screenMethod) {
            ScreenMethod.GET -> HttpMethod.GET
            ScreenMethod.POST -> HttpMethod.POST
            ScreenMethod.PUT -> HttpMethod.PUT
            ScreenMethod.DELETE -> HttpMethod.DELETE
            ScreenMethod.HEAD -> HttpMethod.HEAD
            ScreenMethod.PATCH -> HttpMethod.PATCH
        }

    private fun deserializeAction(response: String): Action {
        return serializer.deserializeAction(response)
    }

    private fun deserializeComponent(response: String): ServerDrivenComponent {
        return serializer.deserializeComponent(response)
    }

    private fun genericErrorMessage(url: String) = "fetchData error for url $url"
}
