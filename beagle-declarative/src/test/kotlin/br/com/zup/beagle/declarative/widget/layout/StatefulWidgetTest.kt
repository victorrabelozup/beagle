package br.com.zup.beagle.declarative.widget.layout

import br.com.zup.beagle.declarative.widget.ui.Text
import org.junit.Assert
import org.junit.Test

class StatefulWidgetTest {

    @Test
    fun build_widget() {
        val widget = Text("DUMMY")

        val subject = StatefulWidget(
            child = widget
        )

        Assert.assertEquals(widget, subject.child)
    }
}