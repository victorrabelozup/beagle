package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import com.fasterxml.jackson.databind.BeanDescription
import com.fasterxml.jackson.databind.JsonSerializer
import com.fasterxml.jackson.databind.ser.std.BeanSerializerBase
import io.mockk.every
import io.mockk.mockk
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import kotlin.test.assertTrue

internal class BeagleSerializerModifierTest {
    @Test
    fun modifySerializer_for_non_Beagle_type_should_return_the_input_serializer() =
        testModifySerializer(clazz = Any::class.java, compareSerializers = Assertions::assertSame) {}

    @Test
    fun modifySerializer_for_Action_should_return_the_BeagleTypeSerializer() =
        testModifySerializer(clazz = Action::class.java, compareSerializers = Assertions::assertNotSame)

    @Test
    fun modifySerializer_for_Screen_should_return_the_BeagleTypeSerializer() =
        testModifySerializer(clazz = Screen::class.java, compareSerializers = Assertions::assertNotSame)

    @Test
    fun modifySerializer_for_ScreenBuilder_should_return_the_BeagleTypeSerializer() =
        testModifySerializer(clazz = ScreenBuilder::class.java, compareSerializers = Assertions::assertNotSame)

    @Test
    fun modifySerializer_for_ServerDrivenComponent_should_return_the_BeagleTypeSerializer() =
        testModifySerializer(clazz = ServerDrivenComponent::class.java, compareSerializers = Assertions::assertNotSame)

    private fun testModifySerializer(
        clazz: Class<*>,
        compareSerializers: (BeanSerializerBase, JsonSerializer<*>) -> Unit,
        validateSerializer: (JsonSerializer<*>) -> Unit = this::validateBeagleTypeSerializer
    ) {
        val description = mockk<BeanDescription>()
        val serializer = mockk<BeanSerializerBase>()

        every { description.beanClass } returns clazz

        val result = BeagleSerializerModifier.modifySerializer(mockk(), description, serializer)

        compareSerializers(serializer, result)
        validateSerializer(result)
    }

    private fun validateBeagleTypeSerializer(serializer: JsonSerializer<*>) =
        assertTrue { serializer is BeagleTypeSerializer }
}