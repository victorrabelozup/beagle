package br.com.zup.beagleui.framework.networking

import androidx.core.util.PatternsCompat
import java.net.URL

internal class UrlFormatter {
    fun format(path: String, endpoint: String): String {
        // path should end with a '/' and ignore anything after it
        val url = URL(path.substring(0, (path.lastIndexOf("/") + 1)))

        // if endpoint has a host, return it as url
        if (PatternsCompat.WEB_URL.matcher(endpoint).matches()) {
            return endpoint
        }

        // if endpoint is an scheme, replace url's scheme
        if (endpoint.startsWith("//")) {
            return replaceUrlScheme(url, endpoint)
        }

        // if endpoint is absolute, replace url's specified path
        if (endpoint.startsWith("/")) {
            return replaceUrlSpecifiedPath(url, endpoint)
        }

        // else just concatenate path and endpoint
        return url.toString() + endpoint
    }

    private fun replaceUrlSpecifiedPath(url: URL, endpoint: String): String {
        return StringBuilder().append(url.protocol).append("://").append(url.host)
            .append(endpoint).toString()
    }

    private fun replaceUrlScheme(url: URL, endpoint: String): String {
        return StringBuilder().append(url.protocol).append(":").append(endpoint).toString()
    }

}