package br.com.zup.beagleui.data

import br.com.zup.beagleui.engine.BeagleUiDeserialization
import br.com.zup.beagleui.engine.framework.core.Widget
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.json.JSONObject
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URL

class BeagleHttpClient(private val deserialization: BeagleUiDeserialization) {

    suspend fun fetchWidget(url: String): Widget = withContext(Dispatchers.IO) {
        val urlConnection = URL(url).openConnection() as HttpURLConnection
        try {
            val response = String(urlConnection.inputStream.readBytes())
            if (response != "") {
                return@withContext deserialization.deserialize(JSONObject(response))
            }
        } finally {
            urlConnection.disconnect()
        }

        throw IOException("Can't retrieve the requested widget")
    }
}