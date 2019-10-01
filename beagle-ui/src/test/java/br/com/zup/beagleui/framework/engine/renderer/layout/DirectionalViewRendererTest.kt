package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.engine.renderer.native.YogaFactory
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.ui.Button
import com.facebook.yoga.YogaFlexDirection
import com.facebook.yoga.YogaNode
import com.facebook.yogalayout.YogaLayout
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.verify
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

internal class DirectionalViewRendererImpl(
    children: List<Widget>,
    flex: Flex,
    viewRendererFactory: ViewRendererFactory,
    viewFactory: ViewFactory,
    yogaFactory: YogaFactory
) : DirectionalViewRenderer(children, flex, viewRendererFactory, viewFactory, yogaFactory) {

    override fun getYogaFlexDirection(): YogaFlexDirection {
        return YogaFlexDirection.COLUMN
    }
}

class DirectionalViewRendererTest {

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var yogaFactory: YogaFactory

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
            viewFactory,
            yogaFactory
        )
    }

    @Test
    fun build_should_add_flexDirection_as_COLUMN_and_addView_to_yogaLayout() {
        // Given
        val yogaLayout = mockk<YogaLayout>()
        val yogaNode = mockk<YogaNode>()
        val context = mockk<Context>()
        val containerViewRenderer = mockk<ContainerViewRenderer>()
        val view = mockk<View>()
        every { yogaNode.flexDirection = any() } just Runs
        every { yogaLayout.context } returns context
        every { yogaLayout.yogaNode } returns yogaNode
        every { yogaLayout.addView(any()) } just Runs
        every { yogaFactory.makeYogaLayout(any(), any()) } returns yogaLayout
        every { viewRendererFactory.make(any()) } returns containerViewRenderer
        every { containerViewRenderer.build(context) } returns view

        // When
        directionalViewRenderer.build(context)

        // Then
        verify { yogaNode.flexDirection = YogaFlexDirection.COLUMN }
        verify(exactly = 2) { yogaLayout.addView(view) }
    }
}