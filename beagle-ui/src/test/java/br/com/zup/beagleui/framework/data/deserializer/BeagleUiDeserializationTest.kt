package br.com.zup.beagleui.framework.data.deserializer

import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.layout.Vertical
import com.squareup.moshi.JsonAdapter
import com.squareup.moshi.Moshi
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*
import kotlin.test.assertFails

class BeagleUiDeserializationTest {

    @MockK
    private lateinit var beagleMoshiFactory: BeagleMoshiFactory
    @MockK
    private lateinit var moshi: Moshi
    @MockK
    private lateinit var jsonAdapter: JsonAdapter<Widget>

    private lateinit var beagleUiDeserialization: BeagleUiDeserialization

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        beagleUiDeserialization = BeagleUiDeserialization(beagleMoshiFactory)

        every { beagleMoshiFactory.make() } returns moshi
        every { moshi.adapter(Widget::class.java) } returns jsonAdapter
    }

    @Test
    fun deserialize_should_return_a_Widget_when_pass_a_valid_json_representation() {
        // Given
        val json = "{}"
        val container = Container(content = Vertical(children = listOf()))
        every { jsonAdapter.fromJson(json) } returns container

        // When
        val actual = beagleUiDeserialization.deserialize(json)

        // Then
        assertEquals(container, actual)
    }

    @Test
    fun deserialize_should_return_a_BeagleDeserializationException_when_fromJson_returns_null() {
        // Given
        val json = "{}"
        every { jsonAdapter.fromJson(json) } returns null

        // When
        val actual = assertFails{ beagleUiDeserialization.deserialize(json) }

        // Then
        assertTrue(actual is BeagleDeserializationException)
    }
}
