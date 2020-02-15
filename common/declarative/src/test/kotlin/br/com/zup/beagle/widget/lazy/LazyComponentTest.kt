package br.com.zup.beagle.widget.lazy

import br.com.zup.beagle.widget.Widget
import io.mockk.mockk
import org.junit.Test
import kotlin.test.assertEquals

class LazyComponentTest {

    @Test
    fun lazyWidget_should_be_create_with_default_values() {
        val url = ""
        val initialState = mockk<Widget>()

        val widget = LazyComponent(url, initialState)

        assertEquals(url, widget.path)
        assertEquals(initialState, widget.initialState)
    }
}