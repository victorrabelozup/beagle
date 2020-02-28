package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class BeagleScreenBuilderSerializerTest {

    @RelaxedMockK
    private lateinit var beagleScreenSerializer: BeagleScreenSerializer

    @InjectMockKs
    private lateinit var beagleScreenBuilderSerializer: BeagleScreenBuilderSerializer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
    }

    @Test
    fun serialize_should_call_beagleScreenSerializer() {
        // Given
        val screenBuilder = mockk<ScreenBuilder>()
        val gen = mockk<JsonGenerator>()
        val provider = mockk<SerializerProvider>()
        val screen = mockk<Screen>()
        every { screenBuilder.build() } returns screen

        // When
        beagleScreenBuilderSerializer.serialize(screenBuilder, gen, provider)

        // Then
        verify(exactly = 1) { beagleScreenSerializer.serialize(screen, gen, provider) }
    }

    @Test
    fun serialize_should_not_call_beagleScreenSerializer_when_screen_is_null() {
        // Given
        val screen = null
        val gen = mockk<JsonGenerator>()
        val provider = mockk<SerializerProvider>()

        // When
        beagleScreenBuilderSerializer.serialize(screen, gen, provider)

        // Then
        verify(exactly = 0) { beagleScreenSerializer.serialize(screen, gen, provider) }
    }

    @Test
    fun serialize_should_not_call_beagleScreenSerializer_when_screen_and_gen_is_null() {
        // Given
        val screen = null
        val gen = null
        val provider = mockk<SerializerProvider>()

        // When
        beagleScreenBuilderSerializer.serialize(screen, gen, provider)

        // Then
        verify(exactly = 0) { beagleScreenSerializer.serialize(screen, gen, provider) }
    }
}