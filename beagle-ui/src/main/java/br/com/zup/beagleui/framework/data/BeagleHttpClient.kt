package br.com.zup.beagleui.framework.data

import br.com.zup.beagleui.framework.data.deserializer.BeagleUiDeserialization
import br.com.zup.beagleui.framework.widget.core.Widget
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URL

internal class BeagleHttpClient(private val deserialization: BeagleUiDeserialization) {

    suspend fun fetchWidget(url: String): Widget = withContext(Dispatchers.IO) {
        val urlConnection = URL(url).openConnection() as HttpURLConnection
        try {
            val response = String(urlConnection.inputStream.readBytes())
            if (response != "") {
                return@withContext deserialization.deserialize(response)
            }
        } finally {
            urlConnection.disconnect()
        }

        throw IOException("Can't retrieve the requested widget")
    }
}