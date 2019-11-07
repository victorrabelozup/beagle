package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.action.Navigate
import br.com.zup.beagleui.framework.action.NavigationActionHandler
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.testutil.RandomData
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.navigation.Navigator
import br.com.zup.beagleui.framework.widget.navigation.NavigatorData
import br.com.zup.beagleui.framework.widget.navigation.NavigatorEventType
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.slot
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class NavigatorViewRendererTest {

    private val navigator = Navigator(
        type = NavigatorEventType.ADD_VIEW,
        value = NavigatorData(path = RandomData.httpUrl()),
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
    private lateinit var navigationActionHandler: NavigationActionHandler

    private val onClickListenerSlot = slot<View.OnClickListener>()

    private lateinit var navigatorViewRenderer: NavigatorViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        navigatorViewRenderer = NavigatorViewRenderer(
            navigator,
            navigationActionHandler,
            viewRendererFactory,
            viewFactory
        )

        val viewRenderer = mockk<ViewRenderer>()
        every { viewRenderer.build(any()) } returns view
        every { view.setOnClickListener(capture(onClickListenerSlot)) } just Runs
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { context.startActivity(any()) } just Runs
    }

    @Test
    fun build_should_make_child_view() {
        val actual = navigatorViewRenderer.build(context)

        assertEquals(view, actual)
    }

    @Test
    fun build_should_call_onClickListener() {
        // Given
        val navigateSlot = slot<Navigate>()
        every { navigationActionHandler.handle(context, capture(navigateSlot)) } just Runs

        // When
        callBuildAndClick()

        // Then
        val navigate = navigateSlot.captured
        assertEquals(navigator.type, navigate.type)
        assertEquals(navigator.value, navigate.value)
    }

    private fun callBuildAndClick() {
        navigatorViewRenderer.build(context)
        onClickListenerSlot.captured.onClick(view)
    }
}
