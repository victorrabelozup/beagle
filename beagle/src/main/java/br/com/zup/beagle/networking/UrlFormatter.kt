package br.com.zup.beagle.networking

import br.com.zup.beagle.utils.isValidUrl
import java.net.MalformedURLException
import java.net.URL

internal class UrlFormatter {
    fun format(endpoint: String, path: String): String {
        // if path has a host, return it as url
        if (path.isValidUrl()) {
            return path
        }

        if (endpoint.isEmpty()) throw MalformedURLException("Invalid base url")

        // endpoint should end with a '/' and ignore anything after it
        val url = URL(endpoint.substring(0, (endpoint.lastIndexOf("/") + 1)))

        // if path is an scheme, replace url's scheme
        if (path.startsWith("//")) {
            return replaceUrlScheme(url, path)
        }

        // if path is absolute, replace url's specified path
        if (path.startsWith("/")) {
            return replaceUrlSpecifiedPath(url, path)
        }

        // else just concatenate endpoint and path
        return url.toString() + path
    }

    private fun replaceUrlSpecifiedPath(url: URL, path: String): String {
        var newUrl = StringBuilder().append(url.protocol).append("://").append(url.host)
        if (url.port != -1) {
            newUrl.append(":").append(url.port)
        }
        return newUrl.append(path).toString()
    }

    private fun replaceUrlScheme(url: URL, path: String): String {
        return StringBuilder().append(url.protocol).append(":").append(path).toString()
    }

}