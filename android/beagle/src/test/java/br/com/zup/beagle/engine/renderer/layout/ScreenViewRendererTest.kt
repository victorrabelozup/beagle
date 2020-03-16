package br.com.zup.beagle.engine.renderer.layout

import android.graphics.Color
import android.view.View
import androidx.appcompat.app.ActionBar
import androidx.appcompat.widget.Toolbar
import br.com.zup.beagle.BaseTest
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRenderer
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.extensions.once
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.view.BeagleActivity
import br.com.zup.beagle.view.BeagleFlexView
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.JustifyContent
import br.com.zup.beagle.widget.layout.ScreenComponent
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.mockkStatic
import io.mockk.slot
import io.mockk.unmockkAll
import io.mockk.verify
import org.junit.Test
import kotlin.test.assertEquals

private const val DEFAULT_COLOR = 0xFFFFFF

class ScreenViewRendererTest : BaseTest() {

    @MockK
    private lateinit var screenComponent: ScreenComponent

    @MockK
    private lateinit var viewRendererFactory: ViewRendererFactory
    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var rootView: RootView
    @RelaxedMockK
    private lateinit var context: BeagleActivity
    @RelaxedMockK
    private lateinit var beagleFlexView: BeagleFlexView
    @MockK
    private lateinit var component: ServerDrivenComponent
    @MockK
    private lateinit var viewRenderer: ViewRenderer<*>
    @RelaxedMockK
    private lateinit var view: View
    @MockK(relaxed = true)
    private lateinit var actionBar: ActionBar
    @RelaxedMockK
    private lateinit var toolbar: Toolbar
    @MockK

    private lateinit var screenViewRenderer: ScreenViewRenderer

    override fun setUp() {
        super.setUp()

        mockkStatic(Color::class)
        mockkObject(BeagleEnvironment)

        every { BeagleEnvironment.beagleSdk } returns mockk(relaxed = true)
        every { viewFactory.makeBeagleFlexView(any()) } returns beagleFlexView
        every { viewFactory.makeBeagleFlexView(any(), any()) } returns beagleFlexView
        every { beagleFlexView.addServerDrivenComponent(any(), any()) } just Runs
        every { beagleFlexView.addView(any(), any<Flex>()) } just Runs
        every { screenComponent.navigationBar } returns null
        every { screenComponent.child } returns component
        every { screenComponent.appearance } returns null
        every { viewRendererFactory.make(any()) } returns viewRenderer
        every { viewRenderer.build(any()) } returns view
        every { Color.parseColor(any()) } returns DEFAULT_COLOR
        every { rootView.getContext() } returns context

        screenViewRenderer = ScreenViewRenderer(
            screenComponent,
            viewRendererFactory,
            viewFactory
        )
    }

    override fun tearDown() {
        super.tearDown()
        unmockkAll()
    }

    @Test
    fun build_should_create_a_screenWidget_with_grow_1_and_justifyContent_SPACE_BETWEEN() {
        // Given
        val flex = slot<Flex>()
        every { viewFactory.makeBeagleFlexView(any(), capture(flex)) } returns beagleFlexView
        every { context.supportActionBar } returns null

        // When
        screenViewRenderer.build(rootView)


        // Then
        assertEquals(1.0, flex.captured.grow)
        assertEquals(JustifyContent.SPACE_BETWEEN, flex.captured.justifyContent)
    }

    @Test
    fun build_should_call_content_builder() {
        // Given
        val content = mockk<ServerDrivenComponent>()
        val flex = slot<Flex>()
        every { screenComponent.child } returns content
        every { beagleFlexView.addView(view, capture(flex)) } just Runs
        every { context.supportActionBar } returns null

        // When
        screenViewRenderer.build(rootView)

        // Then
        verify(atLeast = once()) { beagleFlexView.addServerDrivenComponent(content, rootView)}
    }

    @Test
    fun build_should_hideNavigationBar_when_navigationBar_is_null() {
        // GIVEN
        every { context.supportActionBar } returns actionBar
        every { context.getToolbar() } returns toolbar
        val expected = View.GONE
        every { toolbar.visibility = any() } just Runs
        every { toolbar.visibility } returns expected

        // WHEN
        screenViewRenderer.build(rootView)

        // THEN
        assertEquals(expected, toolbar.visibility)
        verify(atLeast = once()) { actionBar.hide() }
    }
}
