package br.com.zup.beagleui.framework.serialization.jackson

import br.com.zup.beagleui.framework.config.BeagleInitializer
import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import java.lang.reflect.Modifier

private const val TYPE = "type"
private const val BEAGLE_NAMESPACE = "beagle"

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
        gen.writeStringField(TYPE, "$BEAGLE_NAMESPACE:$widgetName")
        gen.writeObjectField(buildResultName, buildResultWidget)
        serializeFields(value, gen)
        gen.writeEndObject()
    }

    private fun buildNativeWidget(value: Widget, gen: JsonGenerator, provider: SerializerProvider) {
        gen.writeStartObject()
        addTypeToJson(value, gen)
        serializeFields(value, gen)
        gen.writeEndObject()
    }

    private fun addTypeToJson(value: Widget, gen: JsonGenerator) {
        val widgetName = getClassName(value)
        val configuration = BeagleInitializer.configuration

        val appName = configuration.appName
        val registeredWidgets = configuration.widgets
        if (registeredWidgets.contains(value::class.java)) {
            gen.writeStringField(TYPE, "$appName:$widgetName")
        } else {
            gen.writeStringField(TYPE, "$BEAGLE_NAMESPACE:$widgetName")
        }
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