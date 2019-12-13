package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.ui.Text
import org.junit.Assert
import org.junit.Test

class UpdatableWidgetTest {

    @Test
    fun build_widget() {
        val list = listOf(
            UpdatableState(
                targetId = "test",
                staticState = Text("UPDATED")
            )
        )
        val widget = Text("DUMMY")

        val id = "text1"

        val subject = UpdatableWidget(
            updateStates = list,
            child = widget, id = id
        )

        Assert.assertEquals(list, subject.updateStates)
        Assert.assertEquals(widget, subject.child)
        Assert.assertEquals(id, subject.id)
    }
}