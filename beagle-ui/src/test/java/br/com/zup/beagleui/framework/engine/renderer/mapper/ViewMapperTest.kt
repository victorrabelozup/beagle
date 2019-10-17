package br.com.zup.beagleui.framework.engine.renderer.mapper

import android.widget.ImageView
import br.com.zup.beagleui.framework.widget.core.ImageContentMode
import org.junit.Test

import org.junit.Assert.*
import org.junit.Before

class ViewMapperTest {

    private lateinit var viewMapper: ViewMapper

    @Before
    fun setUp() {
        viewMapper = ViewMapper()
    }

    @Test
    fun toScaleType_should_return_ScaleType_FIT_XY_when_contentMode_is_FIT_XY() {
        val scaleType = viewMapper.toScaleType(ImageContentMode.FIT_XY)

        assertEquals(ImageView.ScaleType.FIT_XY, scaleType)
    }

    @Test
    fun toScaleType_should_return_ScaleType_FIT_CENTER_when_contentMode_is_FIT_CENTER() {
        val scaleType = viewMapper.toScaleType(ImageContentMode.FIT_CENTER)

        assertEquals(ImageView.ScaleType.FIT_CENTER, scaleType)
    }

    @Test
    fun toScaleType_should_return_ScaleType_CENTER_CROP_when_contentMode_is_CENTER_CROP() {
        val scaleType = viewMapper.toScaleType(ImageContentMode.CENTER_CROP)

        assertEquals(ImageView.ScaleType.CENTER_CROP, scaleType)
    }

    @Test
    fun toScaleType_should_return_ScaleType_CENTER_when_contentMode_is_CENTER() {
        val scaleType = viewMapper.toScaleType(ImageContentMode.CENTER)

        assertEquals(ImageView.ScaleType.CENTER, scaleType)
    }
}