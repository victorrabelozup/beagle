package br.com.zup.beagleui.framework.jackson

import br.com.zup.beagleui.framework.core.NativeWidget
import br.com.zup.beagleui.framework.core.Widget
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import java.lang.reflect.Modifier

class BeagleWidgetSerializer : StdSerializer<Widget>(Widget::class.java) {

    override fun serialize(value: Widget?, gen: JsonGenerator?, provider: SerializerProvider?) {
        if (value != null && gen != null && provider != null) {
            if (value !is NativeWidget) {
                buildNonNativeWidget(value, gen)
            } else {
                buildNativeWidget(value, gen, provider)
            }
        }
    }

    private fun buildNonNativeWidget(value: Widget, gen: JsonGenerator) {
        val widgetName = getClassName(value)
        val buildResultName = value.buildResultName()
        val buildResultWidget = value.build()

        gen.writeStartObject()
        gen.writeStringField("type", "beagle:$widgetName")
        gen.writeObjectField(buildResultName, buildResultWidget)
        serializeFields(value, gen)
        gen.writeEndObject()
    }

    private fun buildNativeWidget(value: Widget, gen: JsonGenerator, provider: SerializerProvider) {
        val widgetName = getClassName(value)

        gen.writeStartObject()
        gen.writeStringField("type", "beagle:$widgetName")
        serializeFields(value, gen)
        gen.writeEndObject()
    }

    private fun serializeFields(value: Widget, gen: JsonGenerator) {
        val fields = Class.forName(value.javaClass.name).declaredFields
        fields.forEach { field ->
            field.isAccessible = true
            val fieldValue = field.get(value)
            if (fieldValue != null && !Modifier.isTransient(field.modifiers)) {
                gen.writeObjectField(field.name, fieldValue)
            }
        }
    }

    private fun getClassName(value: Widget): String {
        return value::class.java.simpleName
    }
}