package br.com.zup.beagleui.framework.setup

import android.app.Application
import android.content.Intent
import br.com.zup.beagleui.framework.action.CustomActionHandler
import br.com.zup.beagleui.framework.extensions.once
import br.com.zup.beagleui.framework.mockdata.CustomWidget
import br.com.zup.beagleui.framework.mockdata.CustomWidgetFactory
import br.com.zup.beagleui.framework.navigation.BeagleDeepLinkHandler
import br.com.zup.beagleui.framework.networking.HttpClient
import br.com.zup.beagleui.framework.widget.core.NativeWidget
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
import kotlin.test.assertEquals
import kotlin.test.assertNotNull

private const val APP_NAME = "beagle"

class BeagleInitializerTest {

    @MockK
    private lateinit var application: Application

    @MockK
    private lateinit var buttonTheme: ButtonTheme

    @MockK
    private lateinit var textAppearanceTheme: TextAppearanceTheme

    @MockK
    private lateinit var intent: Intent

    private lateinit var theme: Theme

    private var beagleDeepLinkHandler: BeagleDeepLinkHandler = object : BeagleDeepLinkHandler {
        override fun getDeepLinkIntent(path: String, data: Map<String, String>?): Intent = intent
    }

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkObject(BeagleEnvironment)

        every { BeagleEnvironment.setup(any(), any(), any()) } just Runs
        every {
            BeagleEnvironment.registerWidget(
                any<Class<NativeWidget>>(),
                any()
            )
        } just Runs
    }

    @After
    fun after() {
        unmockkObject(BeagleEnvironment)
        BeagleEnvironment.theme = null
        BeagleEnvironment.httpClient = null
    }

    @Test
    fun setup_should_call_BeagleEnvironment_setup() {
        BeagleInitializer.setup(APP_NAME, application, Environment.DEBUG)

        verify(exactly = once()) { BeagleEnvironment.setup(APP_NAME, application, Environment.DEBUG) }
    }

    @Test
    fun registerWidget_should_call_BeagleEnvironment_registerWidget() {
        // Given
        val button = CustomWidget::class.java
        val factory = CustomWidgetFactory()

        // When
        BeagleInitializer.registerWidget(button, factory)

        // Then
        verify(exactly = once()) { BeagleEnvironment.registerWidget(button, factory) }
    }

    @Test
    fun beagleDeepLinkHandler_should_call_BeagleEnvironment_beagleDeepLinkHandler() {

        // When
        BeagleInitializer.registerBeagleDeepLinkHandler(beagleDeepLinkHandler)

        // Then
        assertNotNull(BeagleEnvironment.beagleDeepLinkHandler)
        assertEquals(beagleDeepLinkHandler, BeagleEnvironment.beagleDeepLinkHandler)
    }

    @Test
    fun registerTheme_should_call_BeagleEnvironment_registerTheme() {
        theme = Theme(
            buttonTheme = buttonTheme,
            textAppearanceTheme = textAppearanceTheme
        )
        // When
        BeagleInitializer.registerTheme(theme = theme)

        // Then
        assertNotNull(BeagleEnvironment.theme)
        assertEquals(theme, BeagleEnvironment.theme)
        assertEquals(theme.buttonTheme, BeagleEnvironment.theme?.buttonTheme)
        assertEquals(theme.textAppearanceTheme, BeagleEnvironment.theme?.textAppearanceTheme)
    }

    @Test
    fun registerHttpClient_should_call_BeagleEnvironment_registerNetworkingDispatcher() {
        // Given
        val httpClient = mockk<HttpClient>()

        // When
        BeagleInitializer.registerHttpClient(httpClient = httpClient)

        // Then
        verify(exactly = once()) { BeagleEnvironment.httpClient = httpClient }
    }

    @Test
    fun registerCustomActionHandler_should_call_BeagleEnvironment_customActionHandler() {
        val customActionHandler = mockk<CustomActionHandler>()

        // When
        BeagleInitializer.registerCustomActionHandler(customActionHandler)

        // Then
        verify(exactly = once()) { BeagleEnvironment.customActionHandler = customActionHandler }
    }
}
