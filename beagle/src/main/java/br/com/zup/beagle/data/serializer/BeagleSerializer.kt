package br.com.zup.beagle.data.serializer

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.exception.BeagleException
import br.com.zup.beagle.logger.BeagleMessageLogs

private const val EXCEPTION_MESSAGE = "Unexpected error when trying to serialize json="

internal class BeagleSerializer(
    private val beagleMoshiFactory: BeagleMoshi = BeagleMoshi
) {

    @Throws(BeagleException::class)
    fun serializeWidget(widget: Widget): String {
        try {
            return beagleMoshiFactory.moshi.adapter(Widget::class.java).toJson(widget) ?:
            throw NullPointerException()
        } catch (ex: Exception) {
            val message = """
            Did you miss to serialize for Widget ${widget::class.java.simpleName}
        """.trimIndent()
           throw BeagleException("$EXCEPTION_MESSAGE$message")
        }
    }

    @Throws(BeagleException::class)
    fun deserializeWidget(json: String): Widget {
        try {
            return beagleMoshiFactory.moshi.adapter(Widget::class.java).fromJson(json) ?:
                throw NullPointerException()
        } catch (ex: Exception) {
            BeagleMessageLogs.logDeserializationError(json, ex)
            throw makeBeagleDeserializationException(json, ex.message)
        }
    }

    @Throws(BeagleException::class)
    fun deserializeAction(json: String): Action {
        try {
            return beagleMoshiFactory.moshi.adapter(Action::class.java).fromJson(json) ?:
                throw NullPointerException()
        } catch (ex: Exception) {
            BeagleMessageLogs.logDeserializationError(json, ex)
            throw makeBeagleDeserializationException(json, ex.message)
        }
    }

    private fun makeBeagleDeserializationException(json: String, exceptionMessage: String? = null): BeagleException {
        val message = if (exceptionMessage != null) {
            "\nWith exception message=$exceptionMessage"
        } else {
            ""
        }
        return BeagleException("$EXCEPTION_MESSAGE$json$message")
    }
}
