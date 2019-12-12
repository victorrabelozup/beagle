package br.com.zup.beagle.declarative.widget.core

import br.com.zup.beagle.declarative.widget.layout.Container
import br.com.zup.beagle.declarative.widget.ui.Text
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