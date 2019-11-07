package br.com.zup.beagleui.framework.engine.renderer.ui

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.engine.mapper.ViewMapper
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.core.ImageContentMode
import br.com.zup.beagleui.framework.widget.ui.NetworkImage
import com.bumptech.glide.Glide

internal class NetworkImageViewRenderer (
    private val image: NetworkImage,
    private val viewFactory: ViewFactory = ViewFactory(),
    private val viewMapper: ViewMapper = ViewMapper()
) : UIViewRenderer {

    override fun build(context: Context): View {
        return viewFactory.makeImageView(context).apply {
            val contentMode = image.contentMode ?: ImageContentMode.FIT_CENTER
            scaleType = viewMapper.toScaleType(contentMode)
            Glide.with(this).load(image.url).into(this)
        }
    }
}
