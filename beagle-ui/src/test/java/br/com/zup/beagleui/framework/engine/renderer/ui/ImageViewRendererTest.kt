package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.widget.ImageView
import br.com.zup.beagleui.framework.engine.mapper.ViewMapper
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.ui.Image
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.slot
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

private const val DEFAULT_TEXT = "Test"

class ImageViewRendererTest {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var viewMapper: ViewMapper
    @MockK
    private lateinit var imageView: ImageView
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var rootView: RootView

    private val image = Image(DEFAULT_TEXT)

    private lateinit var imageViewRenderer: ImageViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        imageViewRenderer = ImageViewRenderer(image, viewFactory, viewMapper)

        every { rootView.getContext() } returns context
    }

    @Test
    fun build_should_return_a_ImageView_with_desired_scaleType() {
        // Given
        val scaleTypeSlot = slot<ImageView.ScaleType>()
        val scaleType = ImageView.ScaleType.FIT_CENTER
        every { viewFactory.makeImageView(context) } returns imageView
        every { viewMapper.toScaleType(any()) } returns scaleType
        every { imageView.scaleType = capture(scaleTypeSlot) } just Runs

        // When
        val view = imageViewRenderer.build(rootView)

        // Then
        assertTrue(view is ImageView)
        assertEquals(scaleType, scaleTypeSlot.captured)
    }
}