package br.com.zup.beagle.engine.renderer.ui

import android.content.Context
import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.logger.BeagleMessageLogs
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.widget.core.WidgetView
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.mockkObject
import io.mockk.unmockkObject
import org.junit.After
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

class ViewConvertableRendererTest {

    @RelaxedMockK
    private lateinit var widget: WidgetView
    @MockK
    private lateinit var context: Context
    @RelaxedMockK
    private lateinit var view: View
    @MockK
    private lateinit var rootView: RootView

    private lateinit var viewConvertableRenderer: ViewConvertableRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkObject(BeagleMessageLogs)

        every { rootView.getContext() } returns context

        viewConvertableRenderer = ViewConvertableRenderer(widget)

        mockkObject(BeagleEnvironment)
    }

    @After
    fun tearDown() {
        unmockkObject(BeagleEnvironment)
    }

    @Suppress("UNCHECKED_CAST")
    @Test
    fun build_should_make_a_native_view() {
        // Given
        every { widget.toView(rootView.getContext()) } returns view

        // When
        val actual = viewConvertableRenderer.build(rootView)

        // Then
        assertEquals(view, actual)
    }
}
