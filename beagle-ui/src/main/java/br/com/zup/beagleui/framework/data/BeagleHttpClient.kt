package br.com.zup.beagleui.framework.data

import br.com.zup.beagleui.framework.data.deserializer.BeagleDeserializationException
import br.com.zup.beagleui.framework.data.deserializer.BeagleUiDeserialization
import br.com.zup.beagleui.framework.exception.BeagleDataException
import br.com.zup.beagleui.framework.networking.HttpClient
import br.com.zup.beagleui.framework.networking.HttpClientFactory
import br.com.zup.beagleui.framework.networking.RequestData
import br.com.zup.beagleui.framework.widget.core.Widget
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException

internal class BeagleHttpClient(
    private val deserialization: BeagleUiDeserialization = BeagleUiDeserialization(),
    private val requestDispatching: HttpClient = HttpClientFactory().make()
) {

    suspend fun fetchWidget(url: String): Widget = suspendCancellableCoroutine { cont ->
        try {
            requestDispatching.execute(request = RequestData(url),
                onSuccess = { response ->
                    cont.resume(deserializeWidget(String(response.data)))
                }, onError = { error ->
                    cont.resumeWithException(BeagleDataException(error.message, error))
                })
        } catch (e: Exception) {
            cont.resumeWithException(BeagleDataException(e.message, e))
        }
    }

    private fun deserializeWidget(response: String): Widget {
        if (response != "") {
            try {
                return deserialization.deserializeWidget(response)
            } catch (exception: BeagleDeserializationException) {
                throw BeagleDataException("Widget deserialization error for url")
            }
        }

        throw BeagleDataException("The requested widget return were empty response")
    }
}
