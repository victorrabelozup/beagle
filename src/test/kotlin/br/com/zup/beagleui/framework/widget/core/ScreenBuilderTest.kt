package br.com.zup.beagleui.framework.widget.core

import br.com.zup.beagleui.framework.widget.layout.Container
import br.com.zup.beagleui.framework.widget.ui.Text
import org.junit.Test
import kotlin.test.assertTrue

class ScreenBuilderTest {

    @Test
    fun build_should_call_Container_build() {
        // Given
        val screenBuilder = ScreenBuilder()
        val testScreen = TestScreen()

        // When
        val widget = screenBuilder.build(testScreen)

        // Then
        assertTrue(widget is Container)
    }
}

internal class TestScreen : Screen {
    override fun build(): Container = Container(content= Text("hello"))
}