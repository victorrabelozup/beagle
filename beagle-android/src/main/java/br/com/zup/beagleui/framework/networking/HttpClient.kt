package br.com.zup.beagleui.framework.networking

interface HttpClient {

    fun execute(
        request: RequestData,
        onSuccess: (responseData: ResponseData) -> Unit,
        onError: (throwable: Throwable) -> Unit
    ): RequestCall
}