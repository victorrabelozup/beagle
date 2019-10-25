package br.com.zup.beagleui.framework.setup

import android.app.Application
import br.com.zup.beagleui.framework.mockdata.CustomWidgetFactory
import br.com.zup.beagleui.framework.mockdata.CustomWidget
import br.com.zup.beagleui.framework.testutil.setPrivateField
import br.com.zup.beagleui.framework.view.BeagleUIViewModel
import com.facebook.soloader.SoLoader
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockkStatic
import io.mockk.verify
import org.koin.test.inject
import org.junit.Before
import org.junit.Test
import org.koin.test.AutoCloseKoinTest
import kotlin.test.assertEquals
import kotlin.test.assertFails
import kotlin.test.assertNotNull
import kotlin.test.assertTrue

private const val APP_NAME = "sample"

class BeagleEnvironmentTest : AutoCloseKoinTest() {

    @MockK
    private lateinit var application: Application

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkStatic(SoLoader::class)

        every { SoLoader.init(any(), any<Boolean>()) } just Runs

        BeagleEnvironment.setPrivateField("appName", null)
        BeagleEnvironment.setPrivateField("application", null)
    }

    @Test
    fun setup_should_save_application_and_appName() {
        BeagleEnvironment.setup(APP_NAME, application)

        assertEquals(APP_NAME, BeagleEnvironment.appName)
        assertEquals(application, BeagleEnvironment.application)
    }

    @Test
    fun setup_should_start_soLoader() {
        BeagleEnvironment.setup(APP_NAME, application)

        verify(exactly = 1) { SoLoader.init(application, false) }
    }

    @Test
    fun setup_should_start_koin() {
        BeagleEnvironment.setup(APP_NAME, application)

        val viewModel by inject<BeagleUIViewModel>()
        assertNotNull(viewModel)
    }

    @Test
    fun setup_should_throw_exception_when_start_is_called_twice() {
        BeagleEnvironment.setup(APP_NAME, application)

        val message = "You should not call setup() twice"
        assertFails(message = message) { BeagleEnvironment.setup(APP_NAME, application) }
    }

    @Test
    fun setup_should_throw_exception_when_applicationName_is_empty() {
        val message = "appName should be initialized with a non empty value"
        assertFails(message = message) { BeagleEnvironment.setup("", application) }
    }

    @Test
    fun registerWidget_should_add_a_new_Widget() {
        BeagleEnvironment.registerWidget(CustomWidget::class.java, CustomWidgetFactory())

        assertTrue(BeagleEnvironment.widgets.size == 1)
    }
}
