package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.annotation.RegisterWidget
import br.com.zup.beagle.widget.core.ComposeWidget
import br.com.zup.beagle.widget.core.Widget
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.ser.std.StdSerializer

class BeagleWidgetSerializer(
    private val objectFieldSerializer: ObjectFieldSerializer = ObjectFieldSerializer()
) : StdSerializer<Widget>(Widget::class.java) {

    override fun serialize(widget: Widget?, gen: JsonGenerator?, provider: SerializerProvider?) {
        if (widget != null && gen != null) {
            if (widget is ComposeWidget) {
                serializeWidget(widget.build(), gen)
            } else {
                serializeWidget(widget, gen)
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

        if (value::class.annotations.any { it.annotationClass == RegisterWidget::class }) {
            gen.writeStringField(BEAGLE_TYPE, "${this.objectFieldSerializer.beagleApplicationName}:$WIDGET_NAMESPACE:$widgetName")
        } else {
            gen.writeStringField(BEAGLE_TYPE, "$BEAGLE_NAMESPACE:$WIDGET_NAMESPACE:$widgetName")
        }
    }

    private fun getClassName(value: Widget): String {
        return value::class.java.simpleName.toLowerCase()
    }
}
