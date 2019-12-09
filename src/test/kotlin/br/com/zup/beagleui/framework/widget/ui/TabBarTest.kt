package br.com.zup.beagleui.framework.widget.ui

import org.junit.Assert.*
import org.junit.Test

class TabBarTest {

    @Test
    fun build_tabBar() {
        val tabBar = TabBar(
            (listOf("")),
            (listOf(Text("")))
        )

        assertEquals(tabBar.titles.size, 1)
        assertEquals(tabBar.contents.size, 1)
    }
}