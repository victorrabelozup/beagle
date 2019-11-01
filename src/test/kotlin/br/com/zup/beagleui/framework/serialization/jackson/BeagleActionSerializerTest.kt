package br.com.zup.beagleui.framework.serialization.jackson

import br.com.zup.beagleui.framework.action.Action
import com.fasterxml.jackson.core.JsonGenerator
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class BeagleActionSerializerTest {

    @MockK
    private lateinit var objectFieldSerializer: ObjectFieldSerializer
    @MockK
    private lateinit var jsonGenerator: JsonGenerator

    private lateinit var beagleActionSerializer: BeagleActionSerializer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        beagleActionSerializer = BeagleActionSerializer(objectFieldSerializer)

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
        verify(exactly = 1) { jsonGenerator.writeStringField("type", "beagle:action:dumbaction") }
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