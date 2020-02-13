package br.com.zup.beagle.networking

import androidx.core.util.PatternsCompat
import java.net.MalformedURLException

internal class UrlFormatter {

    fun format(endpoint: String, path: String): String {
        // if path has a host, return it as uri
        if (isValidUrl(path)) {
            return path
        }

        if (endpoint.isEmpty() || !isValidUrl(endpoint)) {
            throw MalformedURLException("Invalid baseUrl: $endpoint")
        }

        if (path.isEmpty()) {
            throw MalformedURLException("Invalid path: $path")
        }

        return "$endpoint/$path".replace(Regex("(?<=[^:\\s])(\\/+\\/)"), "/")
    }

    private fun isValidUrl(value: String): Boolean =
        PatternsCompat.WEB_URL.matcher(value).matches()
}