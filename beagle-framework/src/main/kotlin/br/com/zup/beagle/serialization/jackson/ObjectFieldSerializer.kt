package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.setup.BeagleInitializerConfiguration
import com.fasterxml.jackson.core.JsonGenerator
import java.lang.reflect.Modifier

class ObjectFieldSerializer {

    val beagleApplicationName = BeagleInitializerConfiguration.getBeagleApplicationNameOrExitWithFailure()

    fun serializeFields(value: Any, gen: JsonGenerator) {
        val fields = value::class.java.declaredFields
        fields.forEach { field ->
            field.isAccessible = true
            val fieldValue = field.get(value)
            if (fieldValue != null && !Modifier.isTransient(field.modifiers)) {
                gen.writeObjectField(field.name, fieldValue)
            }
        }
    }
}