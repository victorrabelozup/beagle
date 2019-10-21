package br.com.zup.beagleui.framework.networking

internal class URLRequestDispatchingFactory(private val urlFactory: URLFactory) {
    fun make(): URLRequestDispatching {
        //TODO check if the ser provided his own UrlRequestDispatcher. if yes return it
        // if(enviroment.requestDispatcher != null) return enviroment.requestDispatcher
        return URLRequestDispatchingDefault(urlFactory)
    }
}