package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.ui.Text
import org.junit.Test
import kotlin.test.assertEquals

class ScrollViewTest {

    @Test
    fun build_scrollView() {
        val widget = FlexWidget(children = listOf(Text("text")))

        val scrollView = ScrollView(child = widget)

        assertEquals(widget, scrollView.child)
    }
}
