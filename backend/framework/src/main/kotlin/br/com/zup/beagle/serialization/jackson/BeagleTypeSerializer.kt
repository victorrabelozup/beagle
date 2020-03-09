package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.annotation.RegisterWidget
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.core.ComposeComponent
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.ser.BeanPropertyWriter
import com.fasterxml.jackson.databind.ser.impl.BeanAsArraySerializer
import com.fasterxml.jackson.databind.ser.impl.ObjectIdWriter
import com.fasterxml.jackson.databind.ser.std.BeanSerializerBase
import java.util.*

internal class BeagleTypeSerializer : BeanSerializerBase {
    constructor(source: BeanSerializerBase?) : super(source)

    constructor(
        source: BeagleTypeSerializer?,
        objectIdWriter: ObjectIdWriter?
    ) : super(source, objectIdWriter)

    constructor(
        source: BeagleTypeSerializer?,
        toIgnore: MutableSet<String>?
    ) : super(source, toIgnore)

    constructor(
        source: BeagleTypeSerializer?,
        objectIdWriter: ObjectIdWriter?,
        filterId: Any?
    ) : super(source, objectIdWriter, filterId)

    constructor(
        source: BeanSerializerBase?,
        properties: Array<BeanPropertyWriter>,
        filteredProperties: Array<BeanPropertyWriter>
    ) : super(source, properties, filteredProperties)

    override fun withObjectIdWriter(objectIdWriter: ObjectIdWriter) =
        BeagleTypeSerializer(this, objectIdWriter)

    override fun withIgnorals(toIgnore: MutableSet<String>) =
        BeagleTypeSerializer(this, toIgnore)

    override fun asArraySerializer() =
        BeanAsArraySerializer(this)

    override fun withFilterId(filterId: Any?) =
        BeagleTypeSerializer(this, this._objectIdWriter, filterId)

    override fun serialize(bean: Any, generator: JsonGenerator, provider: SerializerProvider) {
        val beagleType = getBeagleType(bean)

        generator.writeStartObject()
        beagleType?.apply { generator.writeStringField(BEAGLE_TYPE, this) }
        super.serializeFields(bean, generator, provider)
        generator.writeEndObject()
    }

    private fun getBeagleType(original: Any): String? {
        val component = when (original) {
            is ComposeComponent -> original.build()
            is ScreenBuilder -> original.build()
            else -> original
        }

        val componentName = component::class.java.simpleName.toLowerCase(Locale.getDefault())

        return when (component) {
            is Action -> "$BEAGLE_NAMESPACE:$ACTION_NAMESPACE:$componentName"
            is Screen -> "$BEAGLE_NAMESPACE:$COMPONENT_NAMESPACE:$SCREEN_COMPONENT"
            is ServerDrivenComponent ->
                if (component::class.annotations.any { it.annotationClass == RegisterWidget::class }) {
                    "$CUSTOM_WIDGET_BEAGLE_NAMESPACE:$COMPONENT_NAMESPACE:$componentName"
                } else {
                    "$BEAGLE_NAMESPACE:$COMPONENT_NAMESPACE:$componentName"
                }
            else -> null
        }
    }
}