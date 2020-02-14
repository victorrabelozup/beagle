package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagle.action.ActionExecutor
import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.data.PreFetchHelper
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.navigation.Touchable
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.slot
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class TouchableViewRendererTest {

    private val touchable = Touchable(
        action = Navigate(NavigationType.ADD_VIEW),
        child = mockk()
    )

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var view: View
    @MockK
    private lateinit var rootView: RootView
    @MockK
    private lateinit var actionExecutor: ActionExecutor

    @MockK
    private lateinit var preFetchHelper: PreFetchHelper

    private val onClickListenerSlot = slot<View.OnClickListener>()

    @InjectMockKs
    private lateinit var touchableViewRenderer: TouchableViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this, relaxUnitFun = true)

        val viewRenderer = mockk<ViewRenderer<*>>()
        every { viewRenderer.build(any()) } returns view
        every { view.setOnClickListener(capture(onClickListenerSlot)) } just Runs
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { context.startActivity(any()) } just Runs
        every { view.context } returns context
    }

    @Test
    fun build_should_make_child_view() {
        val actual = touchableViewRenderer.build(rootView)

        assertEquals(view, actual)
    }

    @Test
    fun build_should_call_onClickListener() {
        // Given
        val navigateSlot = slot<Navigate>()
        every { actionExecutor.doAction(context, capture(navigateSlot)) } just Runs

        // When
        callBuildAndClick()

        // Then
        assertEquals(touchable.action, navigateSlot.captured)
    }

    private fun callBuildAndClick() {
        touchableViewRenderer.build(rootView)
        onClickListenerSlot.captured.onClick(view)
    }
}
