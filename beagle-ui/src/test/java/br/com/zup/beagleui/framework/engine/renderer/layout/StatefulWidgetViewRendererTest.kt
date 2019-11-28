package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.state.StatefulRendererHelper
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.StatefulWidget
import br.com.zup.beagleui.framework.widget.layout.UpdatableState
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget
import br.com.zup.beagleui.framework.widget.ui.Button
import br.com.zup.beagleui.framework.widget.ui.Text
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
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

    @MockK
    private lateinit var rootView: RootView

    @MockK
    private lateinit var statefulRendererHelper: StatefulRendererHelper

    private var updatableWidgetButton: UpdatableWidget = UpdatableWidget(
        child = Button("Click to update"),
        id = "btn1",
        updateStates = listOf(
            UpdatableState(
                targetId = "id1",
                staticState = Text("Draw a racket")
            )
        )
    )

    private var updatableWidgetText: UpdatableWidget = UpdatableWidget(
        child = Text("Default Text1", style = "DesignSystem.Text.H2"),
        id = "txt1",
        updateStates = listOf(
            UpdatableState(
                targetId = "btn1",
                staticState = Button("Draw a racket")
            )
        )
    )

    @MockK
    private lateinit var childWidgetButton: Widget

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
        val rootView = mockStatefulRenderer()

        // When
        val actual = subject.build(rootView)

        // Then
        Assert.assertTrue(actual is View)
    }

    private fun mockStatefulRenderer(): RootView {

        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns viewGroup
        every { viewGroup.childCount } returns 2
        every { viewGroup.getChildAt(0) } returns childViewButton
        every { viewGroup.getChildAt(1) } returns childViewText
        every { statefulWidget.child } returns childWidgetButton
        every { childViewButton.tag } returns updatableWidgetButton
        every { childViewText.tag } returns updatableWidgetText
        every { rootView.getContext() } returns context
        return rootView
    }
}