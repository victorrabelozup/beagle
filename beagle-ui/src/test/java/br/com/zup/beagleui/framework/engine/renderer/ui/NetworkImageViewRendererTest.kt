package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.graphics.drawable.Drawable
import android.view.View
import android.widget.ImageView
import br.com.zup.beagleui.framework.engine.renderer.mapper.ViewMapper
import br.com.zup.beagleui.framework.engine.renderer.native.ViewFactory
import br.com.zup.beagleui.framework.widget.ui.NetworkImage
import com.bumptech.glide.Glide
import com.bumptech.glide.RequestBuilder
import com.bumptech.glide.RequestManager
import io.mockk.MockKAnnotations
import io.mockk.Runs
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.slot
import io.mockk.verify
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*

private const val DEFAULT_URL = "http://teste.com/test.png"

class NetworkImageViewRendererTest {

    @MockK
    private lateinit var viewFactory: ViewFactory
    @MockK
    private lateinit var viewMapper: ViewMapper
    @MockK
    private lateinit var imageView: ImageView
    @MockK
    private lateinit var context: Context
    @MockK
    private lateinit var requestManager: RequestManager
    @MockK
    private lateinit var requestBuilder: RequestBuilder<Drawable>

    private val scaleType = ImageView.ScaleType.FIT_CENTER
    private val networkImage = NetworkImage(DEFAULT_URL)

    private lateinit var networkImageViewRenderer: NetworkImageViewRenderer

    @Before
    fun setUp() {
        MockKAnnotations.init(this)

        mockkStatic(Glide::class)

        every { Glide.with(any<View>()) } returns requestManager
        every { requestManager.load(any<String>()) } returns requestBuilder
        every { requestBuilder.into(any()) } returns mockk()
        every { viewFactory.makeImageView(context) } returns imageView
        every { viewMapper.toScaleType(any()) } returns scaleType
        every { imageView.scaleType = any() } just Runs

        networkImageViewRenderer = NetworkImageViewRenderer(networkImage, viewFactory, viewMapper)
    }

    @Test
    fun build_should_return_a_ImageView_with_desired_scaleType() {
        // Given
        val scaleTypeSlot = slot<ImageView.ScaleType>()
        every { imageView.scaleType = capture(scaleTypeSlot) } just Runs

        // When
        val view = networkImageViewRenderer.build(context)

        // Then
        assertTrue(view is ImageView)
        assertEquals(scaleType, scaleTypeSlot.captured)
    }

    @Test
    fun build_should_set_url_to_Glide() {
        networkImageViewRenderer.build(context)

        verify(exactly = 1) { Glide.with(imageView) }
        verify(exactly = 1) { requestManager.load(DEFAULT_URL) }
        verify(exactly = 1) { requestBuilder.into(imageView) }
    }
}
