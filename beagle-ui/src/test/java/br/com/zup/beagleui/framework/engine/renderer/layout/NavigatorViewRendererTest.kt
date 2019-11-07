package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.content.Intent
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.navigation.BeagleDeepLinkHandler
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.view.BeagleNavigator
import br.com.zup.beagleui.framework.widget.navigation.DeeplinkURL
import br.com.zup.beagleui.framework.widget.navigation.Event
import br.com.zup.beagleui.framework.widget.navigation.EventType
import br.com.zup.beagleui.framework.widget.navigation.Navigator
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.slot
import io.mockk.unmockkObject
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

class NavigatorViewRendererTest {

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var view: View
    @MockK
    private lateinit var navigator: Navigator
    @MockK
    private lateinit var beagleDeepLinkHandler: BeagleDeepLinkHandler

    private val onClickListenerSlot = slot<View.OnClickListener>()

    private lateinit var navigatorViewRenderer: NavigatorViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        navigatorViewRenderer = NavigatorViewRenderer(
            navigator,
            viewRendererFactory,
            viewFactory
        )

        mockkObject(BeagleEnvironment)
        mockkObject(BeagleNavigator)

        val viewRenderer = mockk<ViewRenderer>()
        every { viewRenderer.build(any()) } returns view
        every { view.setOnClickListener(capture(onClickListenerSlot)) } just Runs
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { navigator.child } returns navigator
        every { BeagleEnvironment.beagleDeepLinkHandler } returns beagleDeepLinkHandler
        every { context.startActivity(any()) } just Runs
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleEnvironment)
        unmockkObject(BeagleNavigator)
    }

    @Test
    fun build_should_make_child_view() {
        val actual = navigatorViewRenderer.build(context)

        assertEquals(view, actual)
    }

    @Test
    fun build_should_call_onClickListener_to_openDeepLink() {
        // Given
        val eventData = DeeplinkURL(
            path = "deeplink"
        )
        val event = Event(
            type = EventType.OPEN_DEEP_LINK,
            value = eventData
        )
        val intent = mockk<Intent>()
        every { beagleDeepLinkHandler.getDeepLinkIntent(any()) } returns intent
        every { navigator.event } returns event

        // When
        callBuildAndClick()

        // Then
        verify(exactly = 1) { beagleDeepLinkHandler.getDeepLinkIntent(eventData) }
        verify(exactly = 1) { context.startActivity(intent) }
    }

    @Test
    fun build_should_call_onClickListener_to_openDeepLink_with_null_eventData() {
        // Given
        val event = Event(
            type = EventType.OPEN_DEEP_LINK
        )
        val intent = mockk<Intent>()
        every { beagleDeepLinkHandler.getDeepLinkIntent(any()) } returns intent
        every { navigator.event } returns event

        // When
        callBuildAndClick()

        // Then
        verify(exactly = 0) { BeagleEnvironment.beagleDeepLinkHandler }
    }

    @Test
    fun build_should_call_onClickListener_to_openDeepLink_with_null_deepLinkHandler() {
        // Given
        val eventData = DeeplinkURL(
            path = "deeplink"
        )
        val event = Event(
            type = EventType.OPEN_DEEP_LINK,
            value = eventData
        )
        every { BeagleEnvironment.beagleDeepLinkHandler } returns null
        every { navigator.event } returns event

        // When
        callBuildAndClick()

        // Then
        verify(exactly = 0) { beagleDeepLinkHandler.getDeepLinkIntent(any()) }
    }

    @Test
    fun build_should_call_onClickListener_to_openView() {
        // Given
        val eventData = DeeplinkURL(
            path = "link"
        )
        val event = Event(
            type = EventType.OPEN_VIEW,
            value = eventData
        )
        every { BeagleNavigator.openScreen(any(), any()) } just Runs
        every { navigator.event } returns event

        // When
        callBuildAndClick()

        // Then
        verify(exactly = 1) { BeagleNavigator.openScreen(context, eventData.path) }
    }

    @Test
    fun build_should_call_onClickListener_to_openView_with_null_eventData() {
        // Given
        val event = Event(
            type = EventType.OPEN_VIEW
        )
        every { navigator.event } returns event

        // When
        callBuildAndClick()

        // Then
        verify(exactly = 0) { BeagleNavigator.openScreen(any(), any()) }
    }

    @Test
    fun build_should_call_onClickListener_to_addView() {
        // Given
        val eventData = DeeplinkURL(
            path = "link"
        )
        val event = Event(
            type = EventType.ADD_VIEW,
            value = eventData
        )
        every { BeagleNavigator.addScreen(any(), any()) } just Runs
        every { navigator.event } returns event

        // When
        callBuildAndClick()

        // Then
        verify(exactly = 1) { BeagleNavigator.addScreen(context, eventData.path) }
    }

    @Test
    fun build_should_call_onClickListener_to_addView_with_null_eventData() {
        // Given
        val event = Event(
            type = EventType.ADD_VIEW
        )
        every { navigator.event } returns event

        // When
        callBuildAndClick()

        // Then
        verify(exactly = 0) { BeagleNavigator.addScreen(any(), any()) }
    }

    @Test
    fun build_should_call_onClickListener_to_finishView() {
        // Given
        val event = Event(
            type = EventType.FINISH_VIEW
        )
        every { BeagleNavigator.finish(any()) } just Runs
        every { navigator.event } returns event

        // When
        callBuildAndClick()

        // Then
        verify(exactly = 1) { BeagleNavigator.finish(context) }
    }

    @Test
    fun build_should_call_onClickListener_to_popView() {
        // Given
        val event = Event(
            type = EventType.POP_VIEW
        )
        every { BeagleNavigator.addScreen(any(), any()) } just Runs
        every { navigator.event } returns event

        // When
        callBuildAndClick()

        // Then
        verify(exactly = 1) { BeagleNavigator.pop(context) }
    }

    private fun callBuildAndClick() {
        navigatorViewRenderer.build(context)
        onClickListenerSlot.captured.onClick(view)
    }
}