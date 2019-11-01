package br.com.zup.beagleui.framework.serialization.jackson

import br.com.zup.beagleui.framework.config.BeagleEnvironment
import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import java.lang.reflect.Modifier

private const val TYPE = "type"
private const val WIDGET_NAMESPACE = "widget"
private const val BEAGLE_NAMESPACE = "beagle"

class BeagleWidgetSerializer(
    private val objectFieldSerializer: ObjectFieldSerializer = ObjectFieldSerializer()
) : StdSerializer<Widget>(Widget::class.java) {

    override fun serialize(widget: Widget?, gen: JsonGenerator?, provider: SerializerProvider?) {
        if (widget != null && gen != null) {
            if (widget is NativeWidget) {
                serializeWidget(widget, gen)
            } else {
                serializeWidget(widget.build(), gen)
            }
        }
    }

    private fun serializeWidget(value: Widget, gen: JsonGenerator) {
        gen.writeStartObject()
        addTypeToJson(value, gen)
        objectFieldSerializer.serializeFields(value, gen)
        gen.writeEndObject()
    }

    private fun addTypeToJson(value: Widget, gen: JsonGenerator) {
        val widgetName = getClassName(value)
        val registeredWidgets = BeagleEnvironment.widgets

        if (registeredWidgets.contains(value::class.java)) {
            val appName = BeagleEnvironment.appName
            gen.writeStringField(TYPE, "$appName:$WIDGET_NAMESPACE:$widgetName")
        } else {
            gen.writeStringField(TYPE, "$BEAGLE_NAMESPACE:$WIDGET_NAMESPACE:$widgetName")
        }
    }

    private fun getClassName(value: Widget): String {
        return value::class.java.simpleName.toLowerCase()
    }
}