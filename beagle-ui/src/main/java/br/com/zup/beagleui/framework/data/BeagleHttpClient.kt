package br.com.zup.beagleui.framework.data

import br.com.zup.beagleui.framework.data.deserializer.BeagleDeserializationException
import br.com.zup.beagleui.framework.data.deserializer.BeagleUiDeserialization
import br.com.zup.beagleui.framework.widget.core.Widget
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.net.HttpURLConnection
import java.net.URL

class HttpLayerException(
    override val message: String?
) : Exception()

internal class BeagleHttpClient(private val deserialization: BeagleUiDeserialization) {

    suspend fun fetchWidget(url: String): Widget = withContext(Dispatchers.IO) {
        val urlConnection = URL(url).openConnection() as HttpURLConnection
        try {
            val response = String(urlConnection.inputStream.readBytes())
            return@withContext deserializeWidget(response)
        } finally {
            urlConnection.disconnect()
        }
    }

    private fun deserializeWidget(response: String): Widget {
        if (response != "") {
            try {
                return deserialization.deserialize(response)
            } catch (exception: BeagleDeserializationException) {
                throw HttpLayerException("Widget deserialization error for url")
            }
        }

        throw HttpLayerException("The requested widget return were empty response")
    }
}
