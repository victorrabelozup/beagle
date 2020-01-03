package br.com.zup.beagle.logger

import br.com.zup.beagle.networking.RequestData
import br.com.zup.beagle.networking.ResponseData
import br.com.zup.beagle.widget.core.Widget

internal object BeagleMessageLogs {

    fun logHttpRequestData(requestData: RequestData) {
        BeagleLogger.info("""
            *** HTTP REQUEST ***
            Endpoint=${requestData.endpoint}
            Path=${requestData.path}
            Method=${requestData.method}
            Headers=${requestData.headers}
            Body=${requestData.body}
        """.trimIndent())
    }

    fun logHttpResponseData(responseData: ResponseData) {
        BeagleLogger.info("""
            *** HTTP RESPONSE ***
            StatusCode=${responseData.statusCode}
            Body=${String(responseData.data)}
            Headers=${responseData.headers}
        """.trimIndent())
    }

    fun logUnknownHttpError(throwable: Throwable) {
        BeagleLogger.error("Exception thrown while trying to call http client.", throwable)
    }

    fun logDeserializationError(json: String, ex: Exception) {
        val message = "Exception thrown while trying to deserialize the following json: $json"
        BeagleLogger.error(message, ex)
    }

    fun logViewFactoryNotFoundForWidget(widget: Widget) {
        val message = """
            Did you miss to create a WidgetViewFactory for Widget ${widget::class.java.simpleName}
        """.trimIndent()
        BeagleLogger.warning(message)
    }

    fun logActionBarAlreadyPresentOnView(ex: Exception) {
        BeagleLogger.error("SupportActionBar is already present", ex)
    }

    fun logFormValidatorNotFound(validator: String) {
        BeagleLogger.warning("Validation with name '$validator' were not found!")
    }

    fun logInvalidFormInputState(inputName: String) {
        BeagleLogger.warning("FormInput with name $inputName is not valid" +
                " and does not implement a ValidationErrorListener")
    }

    fun logFormInputsNotFound(formActionName: String) {
        BeagleLogger.warning("Are you missing to declare your FormInput widgets for " +
                "form action '$formActionName'?")
    }

    fun logFormSubmitNotFound(formActionName: String) {
        BeagleLogger.warning("Are you missing to declare your FormSubmit widget for " +
                "form action '$formActionName'?")
    }

    fun logIconResourceNotFound(inputName: String, ex: Exception) {
        BeagleLogger.error("Resource with name $inputName not found", ex)
    }
}