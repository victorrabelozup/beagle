package br.com.zup.beagle.data

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.data.cache.BeagleWidgetCacheHelper
import br.com.zup.beagle.data.serializer.BeagleSerializer
import br.com.zup.beagle.exception.BeagleException
import br.com.zup.beagle.logger.BeagleMessageLogs
import br.com.zup.beagle.networking.HttpClient
import br.com.zup.beagle.networking.HttpClientFactory
import br.com.zup.beagle.networking.RequestData
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.utils.CoroutineDispatchers
import br.com.zup.beagle.utils.isValidUrl
import br.com.zup.beagle.widget.core.Widget
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.withContext
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException

internal class BeagleService(
    private val serializer: BeagleSerializer = BeagleSerializer(),
    private val httpClient: HttpClient = HttpClientFactory().make()
) {
    @Throws(BeagleException::class)
    suspend fun fetchWidget(url: String): Widget {
        return run {
            withContext(CoroutineDispatchers.Default) {
                BeagleWidgetCacheHelper.getWidgetFromCache(url)
            }
        } ?: run {
                val jsonResponse = fetchData(url)
                val widget = deserializeWidget(jsonResponse)
                BeagleWidgetCacheHelper.cacheWidget(url, widget)
            }
        }

    @Throws(BeagleException::class)
    suspend fun fetchAction(url: String): Action {
        val jsonResponse = fetchData(url)
        return deserializeAction(jsonResponse)
    }

    private suspend fun fetchData(url: String): String = suspendCancellableCoroutine { cont ->
        try {
            val call = httpClient.execute(request = makeRequestData(url),
                onSuccess = { response ->
                    BeagleMessageLogs.logHttpResponseData(response)
                    cont.resume(String(response.data))
                }, onError = { error ->
                    BeagleMessageLogs.logUnknownHttpError(error)
                    cont.resumeWithException(BeagleException(error.message ?: genericErrorMessage(url), error))
                }
            )

            cont.invokeOnCancellation {
                call.cancel()
            }
        } catch (ex: Exception) {
            BeagleMessageLogs.logUnknownHttpError(ex)
            cont.resumeWithException(BeagleException(ex.message ?: genericErrorMessage(url), ex))
        }
    }

    private fun makeRequestData(url: String): RequestData {
        val request = if (url.isValidUrl()) {
            RequestData(endpoint = url)
        } else {
            RequestData(endpoint = BeagleEnvironment.beagleSdk.config.baseUrl, path = url)
        }

        BeagleMessageLogs.logHttpRequestData(request)

        return request
    }

    private fun deserializeAction(response: String): Action {
        return serializer.deserializeAction(response)
    }

    private fun deserializeWidget(response: String): Widget {
        return serializer.deserializeWidget(response)
    }

    private fun genericErrorMessage(url: String)  = "fetchData error for url $url"
}
