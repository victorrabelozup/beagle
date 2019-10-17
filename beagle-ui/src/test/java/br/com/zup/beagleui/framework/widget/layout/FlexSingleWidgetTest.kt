package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.ui.Text

import org.junit.Test
import kotlin.test.assertNotNull

class FlexSingleWidgetTest {

    @Test
    fun flexSingleWidget_should_have_flex_as_default_parameter() {
        // Given
        val flexSingleWidget = FlexSingleWidget(child = Text(""))

        // When
        val actual = flexSingleWidget.flex

        // Then
        assertNotNull(actual)
    }
}