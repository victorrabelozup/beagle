package br.com.zup.beagle.declarative.widget.ui

import org.junit.Test
import kotlin.test.assertEquals

class TextTest {

    @Test
    fun build_Text() {
        val text = Text(
            text = "Text",
            alignment = TextAlignment.CENTER
        )

        assertEquals("Text", text.text)
        assertEquals(TextAlignment.CENTER, text.alignment)
    }
}