package br.com.zup.beagle.serialization.jackson

import com.fasterxml.jackson.core.JsonGenerator
import java.lang.reflect.Modifier

class ObjectFieldSerializer {

    fun serializeFields(value: Any, gen: JsonGenerator) {
        var clazz: Class<*> = value::class.java
        while (clazz.name != java.lang.Object::class.java.name) {
            clazz.declaredFields.forEach { field ->
                field.isAccessible = true
                val fieldValue = field.get(value)
                if (fieldValue != null && !Modifier.isTransient(field.modifiers)) {
                    gen.writeObjectField(field.name, fieldValue)
                }
            }
            clazz = clazz.superclass
        }
    }
}