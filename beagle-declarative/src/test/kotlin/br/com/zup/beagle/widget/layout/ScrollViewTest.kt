package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.ui.Text
import org.junit.Test
import kotlin.test.assertEquals

class ScrollViewTest {

    @Test
    fun build_verticalScrollView() {
        val widget = listOf(Text("text"))

        val scrollView = ScrollView(children = widget, scrollDirection = ScrollAxis.VERTICAL)

        assertEquals(widget, scrollView.children)
        assertEquals(ScrollAxis.VERTICAL, scrollView.scrollDirection)
    }

    @Test
    fun build_horizontalScrollView() {
        val widget = listOf(Text("text"))

        val scrollView = ScrollView(children = widget, scrollDirection = ScrollAxis.HORIZONTAL)

        assertEquals(widget, scrollView.children)
        assertEquals(ScrollAxis.HORIZONTAL, scrollView.scrollDirection)
    }
}
