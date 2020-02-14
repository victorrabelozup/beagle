package br.com.zup.beagle.view

import android.content.Context
import android.graphics.Canvas
import androidx.appcompat.widget.AppCompatImageView
import br.com.zup.beagle.utils.applyRadius
import br.com.zup.beagle.utils.getGradientDrawableRadius

internal class BeagleImageView(context: Context) : AppCompatImageView(context) {

    override fun onDraw(canvas: Canvas?) {
        canvas?.applyRadius(getCornerRadiusFromBackground())
        super.onDraw(canvas)
    }

    private fun getCornerRadiusFromBackground(): Float = background.getGradientDrawableRadius()

}