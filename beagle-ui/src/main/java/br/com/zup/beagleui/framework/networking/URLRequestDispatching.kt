package br.com.zup.beagleui.framework.networking

interface URLRequestDispatching {
    fun execute(
        request: RequestData, onSuccess: (responseData: ResponseData) -> Unit,
        onError: (throwable: Throwable) -> Unit
    ): RequestCall?
}