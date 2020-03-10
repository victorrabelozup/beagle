package br.com.zup.beagle.serialization.jackson

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.annotation.RegisterWidget
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.Widget
import br.com.zup.beagle.widget.core.ComposeComponent
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenBuilder
import br.com.zup.beagle.widget.ui.Text
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.ser.std.BeanSerializerBase
import io.mockk.every
import io.mockk.mockk
import io.mockk.verify
import org.junit.jupiter.api.Test
import kotlin.test.assertNotSame
import kotlin.test.assertTrue

internal class BeagleTypeSerializerTest {
    @Test
    fun withObjectIdWriter_should_return_new_BeagleTypeSerializer() {
        val serializer = BeagleTypeSerializer(mockk())

        val result = serializer.withObjectIdWriter(mockk())

        assertNotSame(serializer, result)
        assertTrue(block = result::usesObjectId)
    }

    @Test
    fun withFilterId_should_return_new_BeagleTypeSerializer() {
        val serializer = BeagleTypeSerializer(mockk())

        val result = serializer.withFilterId("Test")

        assertNotSame(serializer, result)
    }

    @Test
    fun serialize_non_beagle_type_should_have_beagleType_field_null() = testSerialize("Text") {
        verify(exactly = 0) { it.writeStringField(BEAGLE_TYPE, any()) }
    }

    @Test
    fun serialize_beagle_native_ServerDrivenComponent_should_have_component_beagleType_field_with_beagle_prefix() =
        testSerialize(Text("test"), "$BEAGLE_NAMESPACE:$COMPONENT_NAMESPACE:text")

    @Test
    fun serialize_custom_ServerDrivenComponent_should_have_component_beagleType_field_with_custom_prefix() =
        testSerialize(CustomWidget, "$CUSTOM_WIDGET_BEAGLE_NAMESPACE:$COMPONENT_NAMESPACE:customwidget")

    @Test
    fun serialize_Action_should_have_action_beagleType_field() =
        testSerialize(
            Navigate(NavigationType.FINISH_VIEW),
            "$BEAGLE_NAMESPACE:$ACTION_NAMESPACE:navigate"
        )

    @Test
    fun serialize_Screen_should_have_screen_beagleType_field() =
        testSerialize(
            Screen(content = CustomWidget),
            "$BEAGLE_NAMESPACE:$COMPONENT_NAMESPACE:$SCREEN_COMPONENT"
        )

    private fun testSerialize(bean: Any, verify: (JsonGenerator) -> Unit) {
        val generator = mockk<JsonGenerator>(relaxUnitFun = true)
        val provider = mockk<SerializerProvider>()

        every { provider.activeView } returns Any::class.java

        BeagleTypeSerializer(mockk(relaxed = true), arrayOf(), arrayOf())
            .serialize(bean, generator, provider)

        verify(generator)
    }

    private fun testSerialize(bean: Any, beagleType: String) = testSerialize(bean) {
        verify(exactly = 1) { it.writeStringField(BEAGLE_TYPE, beagleType) }
    }

    @RegisterWidget
    private object CustomWidget : Widget()
}
