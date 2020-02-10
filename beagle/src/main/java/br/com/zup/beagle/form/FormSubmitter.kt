package br.com.zup.beagle.form

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.data.serializer.BeagleSerializer
import br.com.zup.beagle.exception.BeagleException
import br.com.zup.beagle.networking.HttpClient
import br.com.zup.beagle.networking.HttpClientFactory
import br.com.zup.beagle.networking.HttpMethod
import br.com.zup.beagle.networking.RequestData
import br.com.zup.beagle.networking.URLFactory
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.widget.form.Form
import br.com.zup.beagle.widget.form.FormMethodType

internal sealed class FormResult {
    class Success(val action: Action) : FormResult()
    class Error(val throwable: Throwable) : FormResult()
}

internal class FormSubmitter(
    private val httpClient: HttpClient = HttpClientFactory(URLFactory()).make(),
    private val deserialization: BeagleSerializer = BeagleSerializer()
) {

    fun submitForm(
        form: Form,
        formsValue: Map<String, String>,
        result: (formResult: FormResult) -> Unit
    ) {
        val requestData = createRequestData(form, formsValue)

        httpClient.execute(requestData, { response ->
            try {
                val action = deserialization.deserializeAction(String(response.data))
                result(FormResult.Success(action))
            } catch (ex: BeagleException) {
                result(FormResult.Error(ex))
            }
        }, {
            result(FormResult.Error(it))
        })
    }

    private fun createRequestData(form: Form, formsValue: Map<String, String>): RequestData {
        return RequestData(
            endpoint = BeagleEnvironment.beagleSdk.config.baseUrl,
            path = createUrl(form, formsValue),
            method = when (form.method) {
                FormMethodType.POST -> HttpMethod.POST
                FormMethodType.GET -> HttpMethod.GET
                FormMethodType.PUT -> HttpMethod.PUT
                FormMethodType.DELETE -> HttpMethod.DELETE
            },
            body = createBody(form, formsValue)
        )
    }

    private fun createBody(form: Form, formsValue: Map<String, String>): String? {
        return if (form.method == FormMethodType.POST || form.method == FormMethodType.PUT) {
            formsValue.map {
                """ "${it.key}":"${it.value}" """.trim()
            }.toString().replace("[", "{").replace("]", "}")
        } else {
            null
        }
    }

    private fun createUrl(form: Form, formsValue: Map<String, String>): String {
        return if (form.method == FormMethodType.GET || form.method == FormMethodType.DELETE) {
            var query = if (formsValue.isNotEmpty()) {
                "?"
            } else {
                ""
            }

            for ((index, value) in formsValue.iterator().withIndex()) {
                query += "${value.key}=${value.value}"
                if (index < formsValue.size - 1) {
                    query += "&"
                }
            }

            "${form.action}$query"
        } else {
            form.action
        }
    }
}