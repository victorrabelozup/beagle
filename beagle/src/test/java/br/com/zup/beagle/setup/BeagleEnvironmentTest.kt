package br.com.zup.beagle.setup

import android.app.Application
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.mockdata.CustomWidget
import br.com.zup.beagle.testutil.RandomData
import br.com.zup.beagle.testutil.setPrivateField
import com.facebook.soloader.SoLoader
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockkStatic
import io.mockk.verify
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals
import kotlin.test.assertFails
import kotlin.test.assertTrue

private const val APP_NAME = "sample"

class BeagleEnvironmentTest {

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
        BeagleEnvironment.setup(APP_NAME, application, Environment.DEBUG, RandomData.string())

        assertEquals(APP_NAME, BeagleEnvironment.appName)
        assertEquals(application, BeagleEnvironment.application)
        assertEquals(Environment.DEBUG, BeagleEnvironment.environment)
    }

    @Test
    fun setup_should_start_soLoader() {
        BeagleEnvironment.setup(APP_NAME, application, Environment.DEBUG, RandomData.string())

        verify(exactly = once()) { SoLoader.init(application, false) }
    }

    @Test
    fun setup_should_throw_exception_when_start_is_called_twice() {
        BeagleEnvironment.setup(APP_NAME, application, Environment.DEBUG, RandomData.string())

        val message = "You should not call setup() twice"
        assertFails(message = message) {
            BeagleEnvironment.setup(
                APP_NAME,
                application,
                Environment.DEBUG,
                RandomData.string()
            )
        }
    }

    @Test
    fun setup_should_throw_exception_when_applicationName_is_empty() {
        val message = "appName should be initialized with a non empty value"
        assertFails(message = message) {
            BeagleEnvironment.setup(
                "",
                application,
                Environment.DEBUG,
                RandomData.string()
            )
        }
    }

    @Test
    fun registerWidget_should_add_a_new_Widget() {
        BeagleEnvironment.registerWidget(CustomWidget::class.java)

        assertTrue(BeagleEnvironment.widgets.size == 1)
    }
}
