package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.ui.Text
import org.junit.Test
import kotlin.test.assertEquals

class ScrollViewTest {

    @Test
    fun build_verticalScrollView() {
        val widget = FlexWidget(children = listOf(Text("text")))

        val scrollView = ScrollView(child = widget, scrollDirection = ScrollAxis.VERTICAL)

        assertEquals(widget, scrollView.child)
        assertEquals(ScrollAxis.VERTICAL, scrollView.scrollDirection)
    }

    @Test
    fun build_horizontalScrollView() {
        val widget = FlexWidget(children = listOf(Text("text")))

        val scrollView = ScrollView(child = widget, scrollDirection = ScrollAxis.HORIZONTAL)

        assertEquals(widget, scrollView.child)
        assertEquals(ScrollAxis.HORIZONTAL, scrollView.scrollDirection)
    }
}
