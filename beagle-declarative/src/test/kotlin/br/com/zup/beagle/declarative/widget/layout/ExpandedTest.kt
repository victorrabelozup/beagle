package br.com.zup.beagle.declarative.widget.layout

import br.com.zup.beagle.declarative.widget.ui.Text
import org.junit.Test
import kotlin.test.assertEquals

class ExpandedTest {

    @Test
    fun build_expanded() {
        val widget = ScrollView(listOf(Text("text")))

        val expanded = Expanded(widget)

        assertEquals(widget, expanded.child)
    }
}