package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.ImageContentMode
import org.junit.Test
import kotlin.test.assertEquals

class ImageTest {

    @Test
    fun image_should_have_contentMode_as_ImageContentMode_FIT_CENTER() {
        // Given
        val image = Image("")

        // When
        val contentMode = image.contentMode

        // Then
        assertEquals(ImageContentMode.FIT_CENTER, contentMode)
    }
}