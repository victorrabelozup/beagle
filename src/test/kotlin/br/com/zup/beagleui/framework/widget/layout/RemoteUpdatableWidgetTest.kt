package br.com.zup.beagleui.framework.widget.lazy

import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.RemoteUpdatableWidget
import io.mockk.mockk
import org.junit.Test
import kotlin.test.assertEquals

class RemoteUpdatableWidgetTest {

    @Test
    fun remoteUpdatableWidget_should_be_create_with_default_values() {
        val url = ""
        val initialState = mockk<Widget>()

        val widget = RemoteUpdatableWidget(url, initialState)

        assertEquals(url, widget.url)
        assertEquals(initialState, widget.initialState)
    }
}