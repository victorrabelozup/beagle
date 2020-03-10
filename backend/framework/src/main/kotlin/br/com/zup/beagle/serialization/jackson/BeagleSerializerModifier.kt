package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.core.ComposeComponent
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import com.fasterxml.jackson.databind.BeanDescription
import com.fasterxml.jackson.databind.JsonSerializer
import com.fasterxml.jackson.databind.SerializationConfig
import com.fasterxml.jackson.databind.ser.BeanSerializerModifier
import com.fasterxml.jackson.databind.ser.std.BeanSerializerBase

internal object BeagleSerializerModifier : BeanSerializerModifier() {
    private val beagleBaseClasses = listOf(Action::class.java, Screen::class.java, ServerDrivenComponent::class.java)

    private val beagleBuilders = listOf(ComposeComponent::class.java, ScreenBuilder::class.java)

    override fun modifySerializer(
        config: SerializationConfig,
        description: BeanDescription,
        serializer: JsonSerializer<*>
    ) =
        if (serializer is BeanSerializerBase && isBeagleBuilder(description)) {
            BeagleBuilderSerializer(serializer)
        } else if (serializer is BeanSerializerBase && isBeagleBase(description)) {
            BeagleTypeSerializer(serializer)
        } else {
            serializer
        }

    private fun isBeagleBase(description: BeanDescription) = beagleBaseClasses.findAssignableFrom(description)

    private fun isBeagleBuilder(description: BeanDescription) = beagleBuilders.findAssignableFrom(description)

    private fun List<Class<*>>.findAssignableFrom(description: BeanDescription) =
        this.find { it.isAssignableFrom(description.beanClass) } != null
}
