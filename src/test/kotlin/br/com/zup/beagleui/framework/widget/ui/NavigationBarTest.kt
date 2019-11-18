package br.com.zup.beagleui.framework.widget.ui

import org.junit.Assert.*
import org.junit.Test

class NavigationBarTest {

    @Test
    fun build_navigationBar() {
        val navigationBar = NavigationBar("test")

        assertEquals("test", navigationBar.title)
    }

}
