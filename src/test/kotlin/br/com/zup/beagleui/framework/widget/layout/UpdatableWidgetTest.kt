package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.ui.Text
import org.junit.Assert
import org.junit.Test

class UpdatableWidgetTest {

    @Test
    fun build_widget() {
        val list = listOf("test")
        val widget = Text("DUMMY")
        val event = UpdatableEvent.ON_CLICK
        val id = "text1"

        val subject = UpdatableWidget(
            updateIds = list,
            child = widget, updatableEvent = event, id = id
        )

        Assert.assertEquals(list, subject.updateIds)
        Assert.assertEquals(widget, subject.child)
        Assert.assertEquals(event, subject.updatableEvent)
        Assert.assertEquals(id, subject.id)
    }
}