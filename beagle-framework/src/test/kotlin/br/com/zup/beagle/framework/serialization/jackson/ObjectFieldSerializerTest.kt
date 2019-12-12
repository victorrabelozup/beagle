package br.com.zup.beagle.framework.serialization.jackson

import com.fasterxml.jackson.core.JsonGenerator
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.verify
import org.junit.Before
import org.junit.Test

internal class ObjectFieldSerializerTest {

    @MockK
    private lateinit var jsonGenerator: JsonGenerator

    private lateinit var objectFieldSerializer: ObjectFieldSerializer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        every { jsonGenerator.writeObjectField(any(), any()) } just Runs

        objectFieldSerializer = ObjectFieldSerializer()
    }

    @Test
    fun serializeFields_should_serialize_normal_attributes() {
        // Given
        val value1 = "Test1"
        val value2 = "Test1"
        val objectInstance = NormalObjectToSerialize(value1, value2)

        // When
        objectFieldSerializer.serializeFields(objectInstance, jsonGenerator)

        // Then
        verify(exactly = 1) { jsonGenerator.writeObjectField("testAttr1", value1) }
        verify(exactly = 1) { jsonGenerator.writeObjectField("testAttr2", value2) }
    }

    @Test
    fun serializeFields_should_not_serialize_transient_attributes() {
        // Given
        val objectInstance = TransientObjectToSerialize("value")

        // When
        objectFieldSerializer.serializeFields(objectInstance, jsonGenerator)

        // Then
        verify(exactly = 0) { jsonGenerator.writeObjectField(any(), any()) }
    }

    @Test
    fun serializeFields_should_not_serialize_null_attributes() {
        // Given
        val objectInstance = NullableObjectToSerialize(null)

        // When
        objectFieldSerializer.serializeFields(objectInstance, jsonGenerator)

        // Then
        verify(exactly = 0) { jsonGenerator.writeObjectField(any(), any()) }
    }

    @Test
    fun serializeFields_should_not_serialize_class_without_attributes() {
        // Given
        val objectInstance = NoAttributesObjectToSerialize()

        // When
        objectFieldSerializer.serializeFields(objectInstance, jsonGenerator)

        // Then
        verify(exactly = 0) { jsonGenerator.writeObjectField(any(), any()) }
    }
}

private data class NormalObjectToSerialize(
    val testAttr1: String,
    val testAttr2: String
)

private data class TransientObjectToSerialize(
    @Transient val testAttr1: String
)

private data class NullableObjectToSerialize(
    val testAttr1: String?
)

private class NoAttributesObjectToSerialize