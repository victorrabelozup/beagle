package br.com.zup.beagleui.framework.data.deserializer

import br.com.zup.beagleui.framework.action.Action
import br.com.zup.beagleui.framework.action.Navigate
import br.com.zup.beagleui.framework.testutil.RandomData
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

import java.io.IOException
import kotlin.test.assertEquals
import kotlin.test.assertFails
import kotlin.test.assertTrue

class BeagleUiDeserializationTest {

    @MockK
    private lateinit var beagleMoshiFactory: BeagleMoshiFactory
    @MockK
    private lateinit var moshi: Moshi
    @MockK
    private lateinit var widgetJsonAdapter: JsonAdapter<Widget>
    @MockK
    private lateinit var actionJsonAdapter: JsonAdapter<Action>

    private lateinit var beagleUiDeserialization: BeagleUiDeserialization

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        beagleUiDeserialization = BeagleUiDeserialization(beagleMoshiFactory)

        every { beagleMoshiFactory.make() } returns moshi
        every { moshi.adapter(Widget::class.java) } returns widgetJsonAdapter
        every { moshi.adapter(Action::class.java) } returns actionJsonAdapter
    }

    @Test
    fun deserializeWidget_should_return_a_Widget_when_pass_a_valid_json_representation() {
        // Given
        val json = "{}"
        val container = Container(content = Vertical(children = listOf()))
        every { widgetJsonAdapter.fromJson(json) } returns container

        // When
        val actual = beagleUiDeserialization.deserializeWidget(json)

        // Then
        assertEquals(container, actual)
    }

    @Test
    fun deserializeWidget_should_return_a_BeagleDeserializationException_when_fromJson_returns_null() {
        // Given
        val json = "{}"
        every { widgetJsonAdapter.fromJson(json) } returns null

        // When
        val actual = assertFails{ beagleUiDeserialization.deserializeWidget(json) }

        // Then
        assertTrue(actual is BeagleDeserializationException)
    }

    @Test
    fun deserializeWidget_should_return_a_BeagleDeserializationException_when_fromJson_throws_exception() {
        // Given
        val exception = IOException()
        every { widgetJsonAdapter.fromJson(any<String>()) } throws exception

        // When
        val actual = assertFails() { beagleUiDeserialization.deserializeWidget(RandomData.string()) }

        // Then
        assertTrue(actual is BeagleDeserializationException)
    }

    @Test
    fun deserializeAction_should_return_a_Action_when_pass_a_valid_json_representation() {
        // Given
        val json = "{}"
        val navigate = Navigate()
        every { actionJsonAdapter.fromJson(json) } returns navigate

        // When
        val actual = beagleUiDeserialization.deserializeAction(json)

        // Then
        assertEquals(navigate, actual)
    }

    @Test
    fun deserializeAction_should_return_a_BeagleDeserializationException_when_fromJson_returns_null() {
        // Given
        val json = "{}"
        every { actionJsonAdapter.fromJson(json) } returns null

        // When
        val actual = assertFails{ beagleUiDeserialization.deserializeAction(json) }

        // Then
        assertTrue(actual is BeagleDeserializationException)
    }

    @Test
    fun deserializeAction_should_return_a_BeagleDeserializationException_when_fromJson_throws_exception() {
        // Given
        val exception = IOException()
        every { actionJsonAdapter.fromJson(any<String>()) } throws exception

        // When
        val actual = assertFails { beagleUiDeserialization.deserializeAction(RandomData.string()) }

        // Then
        assertTrue(actual is BeagleDeserializationException)
    }
}
