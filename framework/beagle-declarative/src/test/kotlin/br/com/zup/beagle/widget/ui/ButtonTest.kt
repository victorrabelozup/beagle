package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.action.ShowNativeDialog
import org.junit.Test
import kotlin.test.assertEquals

class ButtonTest {

    private val navigate = Navigate(NavigationType.POP_VIEW)

    @Test
    fun build_button() {
        val button = Button(
            text = "Button",
            style = "myApplicationButtonStyle",
            action = navigate
        )

        assertEquals("Button", button.text)
        assertEquals("myApplicationButtonStyle", button.style)
        assertEquals(navigate, button.action)
    }
}