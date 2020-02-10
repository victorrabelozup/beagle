package br.com.zup.beagle.networking

import br.com.zup.beagle.setup.BeagleEnvironment

internal class HttpClientFactory(private val urlFactory: URLFactory = URLFactory()) {
    fun make(): HttpClient {
        return BeagleEnvironment.beagleSdk.httpClient ?: HttpClientDefault(urlFactory)
    }
}