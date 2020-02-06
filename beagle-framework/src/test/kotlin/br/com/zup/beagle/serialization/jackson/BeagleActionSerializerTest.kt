package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.action.Action
import com.fasterxml.jackson.core.JsonGenerator
import io.mockk.*
import io.mockk.impl.annotations.MockK
import org.junit.Before
import org.junit.Test

class BeagleActionSerializerTest {

    @MockK
    private lateinit var objectFieldSerializer: ObjectFieldSerializer
    @MockK
    private lateinit var jsonGenerator: JsonGenerator

    private lateinit var beagleActionSerializer: BeagleActionSerializer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        beagleActionSerializer = BeagleActionSerializer()

        every { jsonGenerator.writeStartObject() } just Runs
        every { jsonGenerator.writeStringField(any(), any()) } just Runs
        every { jsonGenerator.writeEndObject() } just Runs
        every { jsonGenerator.writeObject(any()) } just Runs
        every { objectFieldSerializer.serializeFields(any(), any()) } just Runs
    }

    @Test
    fun serialize_should_add_type_to_json() {
        // Given
        val action = DumbAction()

        // When
        beagleActionSerializer.serialize(action, jsonGenerator, null)

        // Then
        verify(exactly = 1) { jsonGenerator.writeStartObject() }
        verify(exactly = 1) { jsonGenerator.writeStringField("_beagleType_", "beagle:action:dumbaction") }
        verify(exactly = 1) { jsonGenerator.writeEndObject() }
    }

    @Test
    fun serialize_call_field_serialization() {
        // Given
        val action = DumbAction()

        // When
        beagleActionSerializer.serialize(action, jsonGenerator, null)

        // Then
        verify(exactly = 1) { objectFieldSerializer.serializeFields(action, jsonGenerator) }
    }
}

class DumbAction : Action