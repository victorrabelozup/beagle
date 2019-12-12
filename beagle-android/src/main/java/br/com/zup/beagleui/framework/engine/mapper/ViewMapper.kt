package br.com.zup.beagleui.framework.engine.mapper

import android.widget.ImageView
import br.com.zup.beagleui.framework.widget.core.ImageContentMode

class ViewMapper {

    fun toScaleType(contentMode: ImageContentMode) = when (contentMode) {
        ImageContentMode.FIT_XY -> ImageView.ScaleType.FIT_XY
        ImageContentMode.FIT_CENTER -> ImageView.ScaleType.FIT_CENTER
        ImageContentMode.CENTER_CROP -> ImageView.ScaleType.CENTER_CROP
        ImageContentMode.CENTER -> ImageView.ScaleType.CENTER
    }
}
