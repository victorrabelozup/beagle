package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.ui.Text
import org.junit.Test
import kotlin.test.assertEquals

class PageViewTest {

    @Test
    fun build_page_view() {
        val pages = listOf(Text("Page 1"), Text("Page 2"))

        val pageView = PageView(pages = pages)

        assertEquals(pages, pageView.pages)
    }
}
