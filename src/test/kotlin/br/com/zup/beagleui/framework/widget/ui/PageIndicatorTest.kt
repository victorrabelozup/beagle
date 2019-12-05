package br.com.zup.beagleui.framework.widget.ui

import org.junit.Test
import kotlin.test.assertEquals

class PageIndicatorTest {

    @Test
    fun build_page_indicator() {
        val selectedColor = "#FFFFFF"
        val unselectedColor = "#888888"

        val pageIndicator = PageIndicator(selectedColor, unselectedColor)

        assertEquals(selectedColor, pageIndicator.selectedColor)
        assertEquals(unselectedColor, pageIndicator.unselectedColor)
    }
}
