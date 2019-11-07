package br.com.zup.beagleui.framework.action

import android.content.Context
import android.content.Intent
import br.com.zup.beagleui.framework.navigation.BeagleDeepLinkHandler
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.testutil.RandomData
import br.com.zup.beagleui.framework.view.BeagleNavigator
import br.com.zup.beagleui.framework.widget.navigation.NavigatorData
import br.com.zup.beagleui.framework.widget.navigation.NavigatorEventType
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.unmockkObject
import io.mockk.verify
import net.bytebuddy.matcher.ElementMatchers.any
import org.junit.After
import org.junit.Test

import org.junit.Assert.*
import org.junit.Before

class NavigationActionHandlerTest {

    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var beagleDeepLinkHandler: BeagleDeepLinkHandler

    private lateinit var navigationActionHandler: NavigationActionHandler

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkObject(BeagleEnvironment)
        mockkObject(BeagleNavigator)

        navigationActionHandler = NavigationActionHandler()
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleEnvironment)
        unmockkObject(BeagleNavigator)
    }

    @Test
    fun handle_should_call_openDeepLink_with_null_deepLinkHandler() {
        // Given
        val navigate = Navigate(
            type = NavigatorEventType.OPEN_DEEP_LINK,
            value = NavigatorData(
                path = RandomData.httpUrl()
            )
        )
        every { BeagleEnvironment.beagleDeepLinkHandler } returns null

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = 0) { beagleDeepLinkHandler.getDeepLinkIntent(any()) }
    }

    @Test
    fun handle_should_call_openDeepLink_to_startActivity() {
        // Given
        val navigate = Navigate(
            type = NavigatorEventType.OPEN_DEEP_LINK,
            value = NavigatorData(
                path = RandomData.httpUrl()
            )
        )
        val intent = mockk<Intent>()
        every { context.startActivity(any()) } just Runs
        every { BeagleEnvironment.beagleDeepLinkHandler } returns beagleDeepLinkHandler
        every { beagleDeepLinkHandler.getDeepLinkIntent(any()) } returns intent

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = 1) { context.startActivity(intent) }
    }

    @Test
    fun handle_should_not_try_to_call_deepLinkHandler() {
        // Given
        val navigate = Navigate(
            type = NavigatorEventType.OPEN_DEEP_LINK
        )

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = 0) { beagleDeepLinkHandler.getDeepLinkIntent(any()) }
    }

    @Test
    fun handle_should_call_openView() {
        // Given
        val path = RandomData.httpUrl()
        val navigate = Navigate(
            type = NavigatorEventType.OPEN_VIEW,
            value = NavigatorData(
                path = path
            )
        )
        every { BeagleNavigator.openScreen(any(), any()) } just Runs

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = 1) { BeagleNavigator.openScreen(context, path) }
    }

    @Test
    fun handle_should_call_openView_with_null_eventData() {
        // Given
        val navigate = Navigate(
            type = NavigatorEventType.OPEN_VIEW
        )

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = 0) { BeagleNavigator.openScreen(any(), any()) }
    }

    @Test
    fun handle_should_call__addView() {
        // Given
        val path = RandomData.httpUrl()
        val navigate = Navigate(
            type = NavigatorEventType.ADD_VIEW,
            value = NavigatorData(
                path = path
            )
        )
        every { BeagleNavigator.addScreen(any(), any()) } just Runs

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = 1) { BeagleNavigator.addScreen(context, path) }
    }

    @Test
    fun handle_should_call_addView_with_null_eventData() {
        // Given
        val navigate = Navigate(
            type = NavigatorEventType.ADD_VIEW
        )

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = 0) { BeagleNavigator.addScreen(any(), any()) }
    }

    @Test
    fun handle_should_call_finishView() {
        // Given
        val navigate = Navigate(
            type = NavigatorEventType.FINISH_VIEW
        )
        every { BeagleNavigator.finish(any()) } just Runs

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = 1) { BeagleNavigator.finish(context) }
    }

    @Test
    fun handle_should_call_popView() {
        // Given
        val navigate = Navigate(
            type = NavigatorEventType.POP_VIEW
        )
        every { BeagleNavigator.addScreen(any(), any()) } just Runs

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = 1) { BeagleNavigator.pop(context) }
    }
}