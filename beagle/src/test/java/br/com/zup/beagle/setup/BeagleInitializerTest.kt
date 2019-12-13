package br.com.zup.beagle.setup

import android.app.Application
import android.content.Intent
import br.com.zup.beagle.action.CustomActionHandler
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.mockdata.CustomWidget
import br.com.zup.beagle.mockdata.CustomWidgetFactory
import br.com.zup.beagle.navigation.BeagleDeepLinkHandler
import br.com.zup.beagle.networking.HttpClient
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.widget.core.Widget
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
    private lateinit var intent: Intent

    private var beagleDeepLinkHandler: BeagleDeepLinkHandler = object : BeagleDeepLinkHandler {
        override fun getDeepLinkIntent(path: String, data: Map<String, String>?): Intent = intent
    }

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkObject(BeagleEnvironment)

        every { BeagleEnvironment.setup(any(), any(), any(), any()) } just Runs
        every {
            BeagleEnvironment.registerWidget(
                any<Class<Widget>>(),
                any()
            )
        } just Runs
    }

    @After
    fun after() {
        unmockkObject(BeagleEnvironment)
        BeagleEnvironment.designSystem = null
        BeagleEnvironment.httpClient = null
    }

    @Test
    fun setup_should_call_BeagleEnvironment_setup() {
        val baseUrl = RandomData.httpUrl().toString()
        BeagleInitializer.setup(APP_NAME, application, Environment.DEBUG, baseUrl)

        verify(exactly = once()) {
            BeagleEnvironment.setup(
                APP_NAME,
                application,
                Environment.DEBUG,
                baseUrl
            )
        }
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
    fun registerDesignSystem_should_set_BeagleEnvironment_designSystem() {
        // Given
        val designSystem = mockk<DesignSystem>()

        // When
        BeagleInitializer.registerDesignSystem(designSystem)

        // Then
        assertNotNull(BeagleEnvironment.designSystem)
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
