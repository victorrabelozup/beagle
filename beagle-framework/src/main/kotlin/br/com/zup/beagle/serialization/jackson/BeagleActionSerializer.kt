package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.action.Action
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.ser.std.StdSerializer

class BeagleActionSerializer(
    private val objectFieldSerializer: ObjectFieldSerializer = ObjectFieldSerializer()
) : StdSerializer<Action>(Action::class.java) {

    override fun serialize(action: Action?, gen: JsonGenerator?, provider: SerializerProvider?) {
        if (action != null && gen != null) {
            gen.writeStartObject()
            addTypeToJson(action, gen)
            objectFieldSerializer.serializeFields(action, gen)
            gen.writeEndObject()
        }
    }

    private fun addTypeToJson(value: Action, gen: JsonGenerator) {
        val actionName = getClassName(value)
        gen.writeStringField("_beagleType_", "beagle:action:$actionName")
    }

    private fun getClassName(value: Action): String {
        return value::class.java.simpleName.toLowerCase()
    }
}