package br.com.zup.beagleui.framework.widget.lazy

import br.com.zup.beagleui.framework.widget.core.Widget
import io.mockk.mockk
import org.junit.Test
import kotlin.test.assertEquals

class LazyWidgetTest {

    @Test
    fun lazyWidget_should_be_create_with_default_values() {
        val url = ""
        val initialState = mockk<Widget>()

        val widget = LazyWidget(url, initialState)

        assertEquals(url, widget.url)
        assertEquals(initialState, widget.initialState)
    }
}