package br.com.zup.beagleui.framework.setup

import android.app.Application
import br.com.zup.beagleui.framework.mockdata.CustomWidget
import br.com.zup.beagleui.framework.mockdata.CustomWidgetFactory
import br.com.zup.beagleui.framework.view.WidgetViewFactory
import br.com.zup.beagleui.framework.widget.core.Widget
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockkObject
import io.mockk.unmockkObject
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

private const val APP_NAME = "beagle"

class BeagleInitializerTest {

    @MockK
    private lateinit var application: Application

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkObject(BeagleEnvironment)

        every { BeagleEnvironment.setup(any(), any()) } just Runs
        every {
            BeagleEnvironment.registerWidget(
                any<Class<Widget>>(),
                any<WidgetViewFactory<Widget>>()
            )
        } just Runs
    }

    @After
    fun after() {
        unmockkObject(BeagleEnvironment)
    }

    @Test
    fun setup_should_call_BeagleEnvironment_setup() {
        BeagleInitializer.setup(APP_NAME, application)

        verify(exactly = 1) { BeagleEnvironment.setup(APP_NAME, application) }
    }

    @Test
    fun registerWidget_should_call_BeagleEnvironment_registerWidget() {
        // Given
        val button = CustomWidget::class.java
        val factory = CustomWidgetFactory()

        // When
        BeagleInitializer.registerWidget(button, factory)

        // Then
        verify(exactly = 1) { BeagleEnvironment.registerWidget(button, factory) }
    }
}
