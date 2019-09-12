package br.com.zup.beagleui.framework.data.deserializer

import br.com.zup.beagleui.framework.widget.core.Widget

internal class BeagleUiDeserialization {

    fun deserialize(json: String): Widget {
        return makeMoshi().adapter(Widget::class.java).fromJson(json) ?:
            throw RuntimeException("Unexpected json to serialize: $json")
    }
}