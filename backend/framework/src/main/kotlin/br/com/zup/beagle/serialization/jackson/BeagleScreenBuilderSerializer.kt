package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.widget.layout.ScreenBuilder
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.ser.std.StdSerializer

class BeagleScreenBuilderSerializer(
    private val beagleScreenSerializer: BeagleScreenSerializer = BeagleScreenSerializer()
) : StdSerializer<ScreenBuilder>(ScreenBuilder::class.java) {

    override fun serialize(screen: ScreenBuilder?, gen: JsonGenerator?, provider: SerializerProvider?) {
        if (screen != null && gen != null) {
            beagleScreenSerializer.serialize(screen.build(), gen, provider)
        }
    }
}