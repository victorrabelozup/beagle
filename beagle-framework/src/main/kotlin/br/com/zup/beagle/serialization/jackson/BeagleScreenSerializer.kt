package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.widget.layout.Screen
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.ser.std.StdSerializer

class BeagleScreenSerializer(
    private val objectFieldSerializer: ObjectFieldSerializer = ObjectFieldSerializer()
) : StdSerializer<Screen>(Screen::class.java) {

    override fun serialize(screen: Screen?, gen: JsonGenerator?, provider: SerializerProvider?) {
        if (screen != null && gen != null) {
            gen.writeStartObject()
            gen.writeStringField(BEAGLE_TYPE, "$BEAGLE_NAMESPACE:$WIDGET_NAMESPACE:screenwidget")
            objectFieldSerializer.serializeFields(screen, gen)
            gen.writeEndObject()
        }
    }
}