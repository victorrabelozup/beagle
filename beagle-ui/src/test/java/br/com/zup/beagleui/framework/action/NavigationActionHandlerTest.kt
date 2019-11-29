package br.com.zup.beagleui.framework.action

import android.content.Context
import android.content.Intent
import br.com.zup.beagleui.framework.extensions.once
import br.com.zup.beagleui.framework.navigation.BeagleDeepLinkHandler
import br.com.zup.beagleui.framework.setup.BeagleEnvironment
import br.com.zup.beagleui.framework.testutil.RandomData
import br.com.zup.beagleui.framework.view.BeagleNavigator
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.unmockkObject
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

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
            type = NavigationType.OPEN_DEEP_LINK,
            path = RandomData.httpUrl()
        )
        every { BeagleEnvironment.beagleDeepLinkHandler } returns null

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = 0) { beagleDeepLinkHandler.getDeepLinkIntent(any(), any()) }
    }

    @Test
    fun handle_should_call_openDeepLink_to_startActivity() {
        // Given
        val navigate = Navigate(
            type = NavigationType.OPEN_DEEP_LINK,
            path = RandomData.httpUrl()
        )
        val intent = mockk<Intent>()
        every { context.startActivity(any()) } just Runs
        every { BeagleEnvironment.beagleDeepLinkHandler } returns beagleDeepLinkHandler
        every { beagleDeepLinkHandler.getDeepLinkIntent(any(), any()) } returns intent

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = once()) { context.startActivity(intent) }
    }

    @Test
    fun handle_should_not_try_to_call_deepLinkHandler() {
        // Given
        val navigate = Navigate(
            type = NavigationType.OPEN_DEEP_LINK
        )

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = 0) { beagleDeepLinkHandler.getDeepLinkIntent(any(), any()) }
    }

    @Test
    fun handle_should_call_openView() {
        // Given
        val path = RandomData.httpUrl()
        val navigate = Navigate(
            type = NavigationType.OPEN_VIEW,
            path = path
        )
        every { BeagleNavigator.openScreen(any(), any()) } just Runs

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = once()) { BeagleNavigator.openScreen(context, path) }
    }

    @Test
    fun handle_should_call_openView_with_null_eventData() {
        // Given
        val navigate = Navigate(
            type = NavigationType.OPEN_VIEW
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
            type = NavigationType.ADD_VIEW,
            path = path
        )
        every { BeagleNavigator.addScreen(any(), any()) } just Runs

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = once()) { BeagleNavigator.addScreen(context, path) }
    }

    @Test
    fun handle_should_call_addView_with_null_eventData() {
        // Given
        val navigate = Navigate(
            type = NavigationType.ADD_VIEW
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
            type = NavigationType.FINISH_VIEW
        )
        every { BeagleNavigator.finish(any()) } just Runs

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = once()) { BeagleNavigator.finish(context) }
    }

    @Test
    fun handle_should_call_popView() {
        // Given
        val navigate = Navigate(
            type = NavigationType.POP_VIEW
        )
        every { BeagleNavigator.addScreen(any(), any()) } just Runs

        // When
        navigationActionHandler.handle(context, navigate)

        // Then
        verify(exactly = once()) { BeagleNavigator.pop(context) }
    }
}