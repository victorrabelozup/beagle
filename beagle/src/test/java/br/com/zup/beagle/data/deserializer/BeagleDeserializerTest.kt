package br.com.zup.beagle.data.deserializer

import br.com.zup.beagle.exception.BeagleException
import br.com.zup.beagle.logger.BeagleMessageLogs
import br.com.zup.beagle.action.Action
import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.ui.Button
import com.squareup.moshi.JsonAdapter
import com.squareup.moshi.Moshi
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockkObject
import io.mockk.unmockkObject
import org.junit.After
import org.junit.Before
import org.junit.Test

import java.io.IOException
import kotlin.test.assertEquals
import kotlin.test.assertFails
import kotlin.test.assertTrue

class BeagleDeserializerTest {


    @MockK
    private lateinit var moshi: Moshi
    @MockK
    private lateinit var widgetJsonAdapter: JsonAdapter<Widget>
    @MockK
    private lateinit var actionJsonAdapter: JsonAdapter<Action>

    private lateinit var beagleDeserializer: BeagleDeserializer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        beagleDeserializer = BeagleDeserializer(BeagleMoshi)

        mockkObject(BeagleMessageLogs)
        mockkObject(BeagleMoshi)

        every { BeagleMessageLogs.logDeserializationError(any(), any()) } just Runs
        every { BeagleMoshi.moshi } returns moshi
        every { moshi.adapter(Widget::class.java) } returns widgetJsonAdapter
        every { moshi.adapter(Action::class.java) } returns actionJsonAdapter
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleMessageLogs)
        unmockkObject(BeagleMoshi)
    }

    @Test
    fun deserializeWidget_should_return_a_Widget_when_pass_a_valid_json_representation() {
        // Given
        val json = "{}"
        val button = Button(RandomData.string())
        every { widgetJsonAdapter.fromJson(json) } returns button

        // When
        val actual = beagleDeserializer.deserializeWidget(json)

        // Then
        assertEquals(button, actual)
    }

    @Test
    fun deserializeWidget_should_return_a_BeagleDeserializationException_when_fromJson_returns_null() {
        // Given
        val json = "{}"
        every { widgetJsonAdapter.fromJson(json) } returns null

        // When
        val actual = assertFails{ beagleDeserializer.deserializeWidget(json) }

        // Then
        assertTrue(actual is BeagleException)
    }

    @Test
    fun deserializeWidget_should_return_a_BeagleDeserializationException_when_fromJson_throws_exception() {
        // Given
        val exception = IOException()
        every { widgetJsonAdapter.fromJson(any<String>()) } throws exception

        // When
        val actual = assertFails { beagleDeserializer.deserializeWidget(RandomData.string()) }

        // Then
        assertTrue(actual is BeagleException)
    }

    @Test
    fun deserializeAction_should_return_a_Action_when_pass_a_valid_json_representation() {
        // Given
        val json = "{}"
        val navigate = Navigate(NavigationType.ADD_VIEW)
        every { actionJsonAdapter.fromJson(json) } returns navigate

        // When
        val actual = beagleDeserializer.deserializeAction(json)

        // Then
        assertEquals(navigate, actual)
    }

    @Test
    fun deserializeAction_should_return_a_BeagleDeserializationException_when_fromJson_returns_null() {
        // Given
        val json = "{}"
        every { actionJsonAdapter.fromJson(json) } returns null

        // When
        val actual = assertFails{ beagleDeserializer.deserializeAction(json) }

        // Then
        assertTrue(actual is BeagleException)
    }

    @Test
    fun deserializeAction_should_return_a_BeagleDeserializationException_when_fromJson_throws_exception() {
        // Given
        val exception = IOException()
        every { actionJsonAdapter.fromJson(any<String>()) } throws exception

        // When
        val actual = assertFails { beagleDeserializer.deserializeAction(RandomData.string()) }

        // Then
        assertTrue(actual is BeagleException)
    }
}
