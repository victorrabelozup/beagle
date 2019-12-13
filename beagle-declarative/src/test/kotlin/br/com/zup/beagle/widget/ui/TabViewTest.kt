package br.com.zup.beagle.widget.ui

import org.junit.Assert.*
import org.junit.Test

class TabViewTest {

    @Test
    fun build_tabView() {
        val tabItem1 = TabItem(content = Text(""))
        val tabs = listOf(tabItem1, tabItem1)
        val tabView = TabView(tabs)

        assertEquals(tabs.size, tabView.tabItems.size)
    }
}