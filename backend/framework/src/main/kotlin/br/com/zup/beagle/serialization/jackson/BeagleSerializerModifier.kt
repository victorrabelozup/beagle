package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import com.fasterxml.jackson.databind.BeanDescription
import com.fasterxml.jackson.databind.JsonSerializer
import com.fasterxml.jackson.databind.SerializationConfig
import com.fasterxml.jackson.databind.ser.BeanSerializerModifier
import com.fasterxml.jackson.databind.ser.std.BeanSerializerBase

internal object BeagleSerializerModifier : BeanSerializerModifier() {
    private val beagleComponents = listOf(
        Action::class.java,
        Screen::class.java,
        ScreenBuilder::class.java,
        ServerDrivenComponent::class.java
    )

    override fun modifySerializer(
        config: SerializationConfig,
        description: BeanDescription,
        serializer: JsonSerializer<*>
    ) =
        if (serializer is BeanSerializerBase && isBeagleComponent(description)) {
            BeagleTypeSerializer(serializer)
        } else {
            serializer
        }

    private fun isBeagleComponent(description: BeanDescription) =
        beagleComponents.find { it.isAssignableFrom(description.beanClass) } != null
}