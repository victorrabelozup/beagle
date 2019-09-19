package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import android.widget.ImageView
import br.com.zup.beagleui.framework.widget.ui.Image
import br.com.zup.beagleui.framework.engine.renderer.ViewRenderer
import com.bumptech.glide.Glide

class ImageViewRenderer (
    private val image: Image
) : ViewRenderer {

    override fun build(context: Context): View {
        return ImageView(context).apply {
            Glide.with(this).load(image.path)
        }
    }
}
