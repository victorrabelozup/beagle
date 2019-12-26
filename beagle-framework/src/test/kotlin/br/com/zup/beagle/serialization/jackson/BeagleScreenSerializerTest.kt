package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.widget.layout.Screen
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import io.mockk.MockKAnnotations
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class BeagleScreenSerializerTest {

    @MockK
    private lateinit var objectFieldSerializer: ObjectFieldSerializer
    @MockK
    private lateinit var screen: Screen
    @MockK
    private lateinit var jsonGenerator: JsonGenerator
    @MockK
    private lateinit var serializerProvider: SerializerProvider

    private lateinit var beagleScreenSerializer: BeagleScreenSerializer

    @Before
    fun setUp() {
        MockKAnnotations.init(this, relaxed = true)

        beagleScreenSerializer = BeagleScreenSerializer(objectFieldSerializer)
    }

    @Test
    fun serialize_should_serialize_with_beagleType_and_its_fields() {
        beagleScreenSerializer.serialize(screen, jsonGenerator, serializerProvider)

        verify(exactly = 1) { jsonGenerator.writeStartObject() }
        verify(exactly = 1) { jsonGenerator.writeStringField(BEAGLE_TYPE, "$BEAGLE_NAMESPACE:$WIDGET_NAMESPACE:screenwidget") }
        verify(exactly = 1) { objectFieldSerializer.serializeFields(screen, jsonGenerator) }
        verify(exactly = 1) { jsonGenerator.writeEndObject() }
    }

    @Test
    fun serialize_should_not_serialize_the_object_when_screen_is_null() {
        beagleScreenSerializer.serialize(null, jsonGenerator, serializerProvider)

        verify(exactly = 0) { jsonGenerator.writeStartObject() }
    }

    @Test
    fun serialize_should_not_serialize_the_object_when_jsonGenerator_is_null() {
        beagleScreenSerializer.serialize(screen, null, serializerProvider)

        verify(exactly = 0) { jsonGenerator.writeStartObject() }
    }
}