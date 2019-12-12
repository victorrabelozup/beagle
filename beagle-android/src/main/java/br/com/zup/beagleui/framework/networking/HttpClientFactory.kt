package br.com.zup.beagleui.framework.networking

import br.com.zup.beagleui.framework.setup.BeagleEnvironment

internal class HttpClientFactory(private val urlFactory: URLFactory = URLFactory()) {
    fun make(): HttpClient {
        return BeagleEnvironment.httpClient ?: HttpClientDefault(urlFactory)
    }
}