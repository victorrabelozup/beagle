package br.com.zup.beagleui.framework.config.networking

interface URLRequestDispatching {
    fun execute(
        request: RequestData, success: (responseData: ResponseData) -> Unit,
        onError: (throwable: Throwable) -> Unit
    ): RequestCall?
}