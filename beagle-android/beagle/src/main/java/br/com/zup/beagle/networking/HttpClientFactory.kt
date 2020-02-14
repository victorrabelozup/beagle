package br.com.zup.beagle.networking

import br.com.zup.beagle.setup.BeagleEnvironment

internal class HttpClientFactory {
    fun make(): HttpClient {
        return BeagleEnvironment.beagleSdk.httpClient ?: HttpClientDefault()
    }
}