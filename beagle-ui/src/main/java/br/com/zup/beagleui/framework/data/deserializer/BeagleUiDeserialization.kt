package br.com.zup.beagleui.framework.data.deserializer

import br.com.zup.beagleui.framework.widget.core.Widget

class BeagleDeserializationException(
    override val message: String?
) : Exception()

internal class BeagleUiDeserialization {

    fun deserialize(json: String): Widget {
        return makeMoshi().adapter(Widget::class.java).fromJson(json) ?:
            throw BeagleDeserializationException("Unexpected json to serialize: $json")
    }
}
