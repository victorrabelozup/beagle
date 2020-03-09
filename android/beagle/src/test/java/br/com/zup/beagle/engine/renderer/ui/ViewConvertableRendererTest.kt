package br.com.zup.beagle.engine.renderer.ui

import android.content.Context
import android.view.View
import br.com.zup.beagle.BaseTest
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.widget.core.WidgetView
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import org.junit.Test
import kotlin.test.assertEquals

class ViewConvertableRendererTest : BaseTest() {

    @RelaxedMockK
    private lateinit var widget: WidgetView
    @MockK
    private lateinit var context: Context
    @RelaxedMockK
    private lateinit var view: View
    @MockK
    private lateinit var rootView: RootView

    private lateinit var viewConvertableRenderer: ViewConvertableRenderer

    override fun setUp() {
        super.setUp()

        every { rootView.getContext() } returns context

        viewConvertableRenderer = ViewConvertableRenderer(widget)
    }

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
