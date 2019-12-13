package br.com.zup.beagle.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.FlexDirection
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.ui.Button
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.slot
import io.mockk.verify
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

internal class DirectionalViewRendererImpl(
    children: List<Widget>,
    flex: Flex,
    viewRendererFactory: ViewRendererFactory,
    viewFactory: ViewFactory
) : DirectionalViewRenderer(children, flex, viewRendererFactory, viewFactory) {

    override fun getYogaFlexDirection(): FlexDirection {
        return FlexDirection.COLUMN
    }
}

class DirectionalViewRendererTest {

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory

    private val flex = Flex()
    private val children = listOf(Button(""), Button(""))

    private lateinit var directionalViewRenderer: DirectionalViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        directionalViewRenderer = DirectionalViewRendererImpl(
            children,
            flex,
            viewRendererFactory,
            viewFactory
        )
    }

    @Test
    fun build_should_add_flexDirection_as_COLUMN_and_addView_to_yogaLayout() {
        // Given
        val beagleFlexView = mockk<BeagleFlexView>()
        val context = mockk<Context>()
        val rootView = mockk<RootView>()
        val containerViewRenderer = mockk<ContainerViewRenderer>()
        val view = mockk<View>()
        val flexSlot = slot<Flex>()
        every { rootView.getContext() } returns context
        every { beagleFlexView.context } returns context
        every { beagleFlexView.addView(any()) } just Runs
        every { viewFactory.makeBeagleFlexView(any(), capture(flexSlot)) } returns beagleFlexView
        every { viewRendererFactory.make(any()) } returns containerViewRenderer
        every { containerViewRenderer.build(rootView) } returns view

        // When
        directionalViewRenderer.build(rootView)

        // Then
        assertEquals(FlexDirection.COLUMN, flexSlot.captured.flexDirection)
        verify(exactly = 2) { beagleFlexView.addView(view) }
    }
}