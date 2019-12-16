package br.com.zup.beagle.engine.renderer.ui

import android.content.Context
import android.widget.ImageView
import br.com.zup.beagle.engine.mapper.ViewMapper
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.utils.setData
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ui.Image
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.verify
import junit.framework.Assert.assertTrue
import org.junit.Before
import org.junit.Test

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
    @MockK
    private lateinit var image: Image

    private lateinit var imageViewRenderer: ImageViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        imageViewRenderer = ImageViewRenderer(image, viewFactory, viewMapper)

        every { rootView.getContext() } returns context
    }

    @Test
    fun build_should_return_a_image_view_instance_and_set_data() {
        // Given
        every { viewFactory.makeImageView(context) } returns imageView
        every { imageView.setData(image, viewMapper) } just Runs

        // When
        val view = imageViewRenderer.build(rootView)

        // Then
        assertTrue(view is ImageView)
        verify(exactly = 1) { imageView.setData(image, viewMapper) }
    }
}
