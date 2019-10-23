package br.com.zup.beagleui.framework.networking

import br.com.zup.beagleui.framework.setup.BeagleEnvironment

internal class URLRequestDispatchingFactory(private val urlFactory: URLFactory) {
    fun make(): URLRequestDispatching {
        return BeagleEnvironment.networkingDispatcher ?: URLRequestDispatchingDefault(urlFactory)
    }
}