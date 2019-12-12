package br.com.zup.beagle.declarative.widget.ui

import org.junit.Assert.*
import org.junit.Test

class NavigationBarTest {

    @Test
    fun build_navigationBar() {
        val navigationBar = NavigationBar("test", Button(""), Button(""))

        assertEquals("test", navigationBar.title)
    }

}
