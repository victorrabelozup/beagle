package br.com.zup.beagleui.framework.data.deserializer

import br.com.zup.beagleui.framework.widget.core.Widget

internal class BeagleDeserializationException(
    override val message: String?
) : Exception()

internal class BeagleUiDeserialization(
    private val beagleMoshiFactory: BeagleMoshiFactory = BeagleMoshiFactory()
) {

    fun deserialize(json: String): Widget {
        return beagleMoshiFactory.make().adapter(Widget::class.java).fromJson(json) ?:
            throw BeagleDeserializationException("Unexpected json to serialize: $json")
    }
}
