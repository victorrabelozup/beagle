package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.layout.UpdatableWidget
import br.com.zup.beagle.widget.ui.Text
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test

class UpdatableWidgetViewRendererTest {
    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory:  ViewFactory

    @MockK
    private lateinit var updatableWidget: UpdatableWidget

    @MockK
    private lateinit var text: Text

    @InjectMockKs
    private lateinit var viewRenderer: UpdatableWidgetViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this, relaxUnitFun = true)
    }

    @Test
    fun build_widget() {
        // Given
        val rootView = mockk<RootView>()
        val view = mockk<View>()

        every { updatableWidget.child } returns text
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view
        every { view.tag } returns updatableWidget

        // When
        viewRenderer.build(rootView)

        verify(exactly = once()) { viewRendererFactory.make(updatableWidget.child) }
    }
}