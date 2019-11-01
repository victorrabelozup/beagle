package br.com.zup.beagleui.framework.serialization.jackson

import com.fasterxml.jackson.core.JsonGenerator
import java.lang.reflect.Modifier

class ObjectFieldSerializer {

    fun serializeFields(value: Any, gen: JsonGenerator) {
        val fields = Class.forName(value.javaClass.name).declaredFields
        fields.forEach { field ->
            field.isAccessible = true
            val fieldValue = field.get(value)
            if (fieldValue != null && !Modifier.isTransient(field.modifiers)) {
                gen.writeObjectField(field.name, fieldValue)
            }
        }
    }
}