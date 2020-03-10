package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.widget.core.ComposeComponent
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.ui.Text
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import io.mockk.*
import org.junit.jupiter.api.Test
import kotlin.test.assertEquals
import kotlin.test.assertNotSame
import kotlin.test.assertTrue

internal class BeagleBuilderSerializerTest {
    @Test
    fun withObjectIdWriter_should_return_new_BeagleBuilderSerializer() {
        val serializer = BeagleBuilderSerializer(mockk())

        val result = serializer.withObjectIdWriter(mockk())

        assertNotSame(serializer, result)
        assertTrue(block = result::usesObjectId)
    }

    @Test
    fun withFilterId_should_return_new_BeagleBuilderSerializer() {
        val serializer = BeagleBuilderSerializer(mockk())

        val result = serializer.withFilterId("Test")

        assertNotSame(serializer, result)
    }

    @Test
    fun serialize_non_beagle_builder_should_write_itself() = testSerialize("Test", "Test")

    @Test
    fun serialize_ComposeComponent_should_write_the_component_from_build() =
        testSerialize(
            object : ComposeComponent() {
                override fun build() = Text("Test")
            },
            Text("Test")
        )

    @Test
    fun serialize_ScreenBuilder_should_write_the_component_from_build() =
        testSerialize(
            object : ScreenBuilder {
                override fun build() = Screen(content = Text("Test"))
            },
            Screen(content = Text("Test"))
        )

    private inline fun <reified T : Any> testSerialize(bean: Any, built: T) {
        val generator = mockk<JsonGenerator>()
        val builtSlot = slot<T>()

        every { generator.writeObject(capture(builtSlot)) } just Runs

        BeagleBuilderSerializer(mockk(relaxed = true), arrayOf(), arrayOf())
            .serialize(bean, generator, mockk())

        verify(exactly = 1) { generator.writeObject(any()) }
        assertEquals(built, builtSlot.captured)
    }
}
