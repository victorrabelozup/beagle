package br.com.zup.beagleui.framework.data.deserializer

import br.com.zup.beagleui.framework.action.Action
import br.com.zup.beagleui.framework.widget.core.Widget
import java.io.IOException

private const val EXCEPTION_MESSAGE = "Unexpected error when trying to serialize json:"

internal class BeagleDeserializationException(
    override val message: String
) : Exception()

internal class BeagleUiDeserialization(
    private val beagleMoshiFactory: BeagleMoshiFactory = BeagleMoshiFactory()
) {

    fun deserializeWidget(json: String): Widget {
        try {
            return beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json) ?:
                throw makeBeagleDeserializationException(json)
        } catch (ex: IOException) {
            throw makeBeagleDeserializationException(json)
        }
    }

    fun deserializeAction(json: String): Action {
        try {
            return beagleMoshiFactory.make().adapter(Action::class.java).fromJson(json) ?:
                throw makeBeagleDeserializationException(json)
        } catch (ex: IOException) {
            throw makeBeagleDeserializationException(json)
        }
    }

    private fun makeBeagleDeserializationException(json: String): BeagleDeserializationException {
        return BeagleDeserializationException("$EXCEPTION_MESSAGE $json")
    }
}
