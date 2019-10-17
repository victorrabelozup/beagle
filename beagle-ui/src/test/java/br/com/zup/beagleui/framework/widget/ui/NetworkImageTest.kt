package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.ImageContentMode
import org.junit.Test

class NetworkImageTest {

    @Test
    fun image_should_have_contentMode_as_ImageContentMode_FIT_CENTER() {
        // Given
        val image = NetworkImage("")

        // When
        val contentMode = image.contentMode

        // Then
        kotlin.test.assertEquals(ImageContentMode.FIT_CENTER, contentMode)
    }
}