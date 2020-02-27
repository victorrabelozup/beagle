package br.com.zup.beagle.view

import android.content.Context
import android.graphics.Canvas
import androidx.appcompat.widget.AppCompatImageView
import br.com.zup.beagle.utils.applyRadius

internal class BeagleImageView(context: Context) : AppCompatImageView(context) {

    var cornerRadius = 0.0f

    override fun onDraw(canvas: Canvas?) {
        canvas?.applyRadius(cornerRadius)
        super.onDraw(canvas)
    }
}