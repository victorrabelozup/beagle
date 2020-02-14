package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.annotation.RegisterWidget
import br.com.zup.beagle.widget.core.ComposeComponent
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.ser.std.StdSerializer

class BeagleComponentSerializer(
    private val objectFieldSerializer: ObjectFieldSerializer = ObjectFieldSerializer()
) : StdSerializer<ServerDrivenComponent>(ServerDrivenComponent::class.java) {

    override fun serialize(component: ServerDrivenComponent?, gen: JsonGenerator?, provider: SerializerProvider?) {
        if (component != null && gen != null) {
            if (component is ComposeComponent) {
                serializeComponent(component.build(), gen)
            } else {
                serializeComponent(component, gen)
            }
        }
    }

    private fun serializeComponent(value: ServerDrivenComponent, gen: JsonGenerator) {
        gen.writeStartObject()
        addTypeToJson(value, gen)
        this.objectFieldSerializer.serializeFields(value, gen)
        gen.writeEndObject()
    }

    private fun addTypeToJson(value: ServerDrivenComponent, gen: JsonGenerator) {
        val widgetName = getClassName(value)
        if (value::class.annotations.any { it.annotationClass == RegisterWidget::class }) {
            gen.writeStringField(BEAGLE_TYPE, "$CUSTOM_WIDGET_BEAGLE_NAMESPACE:$COMPONENT_NAMESPACE:$widgetName")
        } else {
            gen.writeStringField(BEAGLE_TYPE, "$BEAGLE_NAMESPACE:$COMPONENT_NAMESPACE:$widgetName")
        }
    }

    private fun getClassName(value: ServerDrivenComponent): String {
        return value::class.java.simpleName.toLowerCase()
    }
}
