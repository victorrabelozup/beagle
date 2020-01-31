package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.engine.renderer.ui.ButtonViewRenderer
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Appearance
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.FlexSingleWidget
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.called
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.just
import io.mockk.mockkStatic
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

class FlexSingleWidgetViewRendererTest {

    @MockK
    private lateinit var flexSingleWidget: FlexSingleWidget
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory

    @MockK
    private lateinit var flex: Flex
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var childWidget: Widget
    @RelaxedMockK
    private lateinit var beagleFlexView: BeagleFlexView
    @MockK
    private lateinit var buttonViewRenderer: ButtonViewRenderer

    @RelaxedMockK
    private lateinit var gradientDrawable: GradientDrawable

    private val backgroundColor = "#FFFFFF"
    private val backgroundColorInt = 0

    @RelaxedMockK
    private lateinit var appearance: Appearance

    @InjectMockKs
    private lateinit var flexSingleWidgetViewRenderer: FlexSingleWidgetViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkStatic(Color::class)

        every { flexSingleWidget.flex } returns flex
        every { flexSingleWidget.child } returns childWidget
        every { flexSingleWidget.appearance } returns appearance
        every { appearance.backgroundColor } returns backgroundColor
        every { viewFactory.makeBeagleFlexView(any(), any()) } returns beagleFlexView
        every { viewRendererFactory.make(childWidget) } returns buttonViewRenderer
        every { buttonViewRenderer.build(any()) } returns beagleFlexView
        every { beagleFlexView.addView(any(), flex) } just Runs
        every { beagleFlexView.setBackgroundColor(any()) } just Runs
        every { rootView.getContext() } returns context
        every { Color.parseColor(any()) } returns backgroundColorInt
        every { beagleFlexView.background } returns gradientDrawable
    }

    @After
    fun tearDown() {
        unmockkStatic(Color::class)
    }

    @Test
    fun build_should_makeBeagleFlexView() {
        flexSingleWidgetViewRenderer.build(rootView)

        verify(exactly = once()) { viewFactory.makeBeagleFlexView(context, flex) }
    }

    @Test
    fun build_should_make_a_view_from_a_child_widget() {
        flexSingleWidgetViewRenderer.build(rootView)

        verify(exactly = once()) { viewRendererFactory.make(childWidget) }
        verify(exactly = once()) { buttonViewRenderer.build(rootView) }
    }

    @Test
    fun build_should_addView_to_BeagleFlexView() {
        flexSingleWidgetViewRenderer.build(rootView)

        verify(exactly = once()) { beagleFlexView.addView(beagleFlexView, flex) }
    }

    @Test
    fun build_should_setBackground_to_BeagleFlexView() {
        flexSingleWidgetViewRenderer.build(rootView)

        if (appearance.backgroundColor != null)
            verify(exactly = once()) { (beagleFlexView.background as? GradientDrawable)?.setColor(backgroundColorInt) }
        else
            verify { beagleFlexView.setBackground(any()) wasNot called }
    }
}