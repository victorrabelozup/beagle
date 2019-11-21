package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.text.TextWatcher
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.StatefulWidget
import br.com.zup.beagleui.framework.widget.layout.UpdatableEvent
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Text
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.slot
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class StatefulWidgetViewRendererTest {
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory

    @MockK
    private lateinit var viewFactory: ViewFactory

    @MockK
    private lateinit var statefulWidget: StatefulWidget

    private var updatableWidgetButton: UpdatableWidget = UpdatableWidget(
        updateIds = listOf("id1"),
        child = Button("Click"),
        updatableEvent = UpdatableEvent.ON_CLICK
    )

    private var updatableWidgetText: UpdatableWidget = UpdatableWidget(
        updateIds = listOf("id1"),
        id = "id1",
        child = Text("Text1"),
        updatableEvent = UpdatableEvent.ON_TEXT_CHANGE
    )

    @MockK
    private lateinit var childWidgetButton: Widget

    @MockK
    private lateinit var childWidgetText: Widget

    private val buttonListenerSlot = slot<View.OnClickListener>()
    private val textWatcherSlot = slot<TextWatcher>()

    @InjectMockKs
    private lateinit var subject: StatefulWidgetViewRenderer

    private val context = mockk<Context>()
    private val viewRenderer = mockk<ViewRenderer>()
    private val viewGroup = mockk<ViewGroup>()
    private val childViewButton = mockk<View>(relaxUnitFun = true)
    private val childViewText = mockk<TextView>(relaxUnitFun = true)

    @Before
    fun setUp() {
        MockKAnnotations.init(this, relaxUnitFun = true)
    }

    @Test
    fun test_build() {
        // Given
        val context = mockStatefulRenderer()

        // When
        val actual = subject.build(context)

        // Then
        Assert.assertTrue(actual is View)
    }

    private fun mockStatefulRenderer(): Context {

        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns viewGroup
        every { viewGroup.childCount } returns 2
        every { viewGroup.getChildAt(0) } returns childViewButton
        every { viewGroup.getChildAt(1) } returns childViewText
        every { statefulWidget.child } returns childWidgetButton
        every { childViewButton.tag } returns updatableWidgetButton
        every { childViewText.tag } returns updatableWidgetText
        return context
    }

    @Test
    fun test_notify() {
        //Given
        val context = mockStatefulRenderer()
        every { childViewButton.setOnClickListener(capture(buttonListenerSlot)) } just Runs
        every { childViewText.addTextChangedListener(capture(textWatcherSlot)) } just Runs

        // When
        val actual = subject.build(context)

        buttonListenerSlot.captured.onClick(childViewButton)
        textWatcherSlot.captured.onTextChanged("DUMMY", 0, 0, 0)

        // Then
    }
}