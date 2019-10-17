package br.com.zup.beagleui.framework.widget.layout

import org.junit.Test
import kotlin.test.assertNotNull

class FlexWidgetTest {

    @Test
    fun flexWidget_should_have_flex_as_default_parameter() {
        // Given
        val flexWidget = FlexWidget(children = listOf())

        // When
        val actual = flexWidget.flex

        // Then
        assertNotNull(actual)
    }
}