package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.ui.Text
import org.junit.Assert
import org.junit.Test

class UpdatableWidgetTest {

    @Test
    fun build_widget() {
        val event = UpdatableEvent.ON_CLICK
        val list = listOf(
            UpdatableState(
                stateType = UpdatableStateType.STATIC,
                targetId = "test",
                targetState = Text("UPDATED"),
                updatableEvent = event
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