package br.com.zup.beagleui.framework.serialization.jackson

import br.com.zup.beagleui.framework.config.BeagleEnvironment
import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Text
import com.fasterxml.jackson.core.JsonGenerator
import io.mockk.*
import io.mockk.impl.annotations.MockK
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

private const val APP_NAME = "test"

class BeagleWidgetSerializerTest {

    @MockK
    private lateinit var jsonGenerator: JsonGenerator

    private val keyStringFieldCaptured = mutableListOf<String>()
    private val valueStringFieldCaptured = mutableListOf<String>()

    private val keyObjectFieldCaptured = mutableListOf<String>()
    private val valueObjectFieldCaptured = mutableListOf<Any>()

    private lateinit var beagleWidgetSerializer: BeagleWidgetSerializer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        beagleWidgetSerializer = BeagleWidgetSerializer()

        every { jsonGenerator.writeStartObject() } just Runs
        every { jsonGenerator.writeStringField(capture(keyStringFieldCaptured), capture(valueStringFieldCaptured)) } just Runs
        every { jsonGenerator.writeObjectField(capture(keyObjectFieldCaptured), capture(valueObjectFieldCaptured)) } just Runs
        every { jsonGenerator.writeEndObject() } just Runs
        every { jsonGenerator.writeObject(any()) } just Runs
    }

    @Test
    fun serialize_should_serialize_a_NativeWidget() {
        // Given
        val textValue = "Hello"
        val widget = Text(textValue)

        // When
        beagleWidgetSerializer.serialize(widget, jsonGenerator, null)

        // Then
        verify(exactly = 1) { jsonGenerator.writeStartObject() }
        verify(exactly = 1) { jsonGenerator.writeEndObject() }

        assertEquals("type", keyStringFieldCaptured[0])
        assertEquals("beagle:Text", valueStringFieldCaptured[0])

        assertEquals("text", keyObjectFieldCaptured[0])
        assertEquals(textValue, valueObjectFieldCaptured[0])
    }

    @Test
    fun serialize_should_serialize_a_CustomWidget() {
        // Given
        val testValue = "Hello"
        val widget = CustomWidget(testValue)

        // When
        beagleWidgetSerializer.serialize(widget, jsonGenerator, null)

        // Then
        verify(exactly = 1) { jsonGenerator.writeStartObject() }
        verify(exactly = 1) { jsonGenerator.writeEndObject() }

        assertEquals("type", keyStringFieldCaptured[0])
        assertEquals("beagle:Button", valueStringFieldCaptured[0])

        assertEquals("text", keyObjectFieldCaptured[0])
        assertEquals(testValue, valueObjectFieldCaptured[0])
    }

    @Test
    fun serialize_should_serialize_a_CustomNativeWidget() {
        // Given
        BeagleEnvironment.setup(APP_NAME)
        BeagleEnvironment.registerWidget(CustomNativeWidget::class.java)
        val widget = CustomNativeWidget()

        // When
        beagleWidgetSerializer.serialize(widget, jsonGenerator, null)

        // Then
        verify(exactly = 1) { jsonGenerator.writeStartObject() }
        verify(exactly = 1) { jsonGenerator.writeEndObject() }

        assertEquals("type", keyStringFieldCaptured[0])
        assertEquals("$APP_NAME:CustomNativeWidget", valueStringFieldCaptured[0])
    }
}

class CustomWidget(
    private val value: String
) : Widget {
    override fun build(): Widget = Button(value)
}

class CustomNativeWidget : NativeWidget