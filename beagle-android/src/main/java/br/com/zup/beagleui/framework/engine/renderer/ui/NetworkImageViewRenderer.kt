package br.com.zup.beagleui.framework.engine.renderer.ui

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.UIViewRenderer
import br.com.zup.beagleui.framework.engine.mapper.ViewMapper
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.core.ImageContentMode
import br.com.zup.beagleui.framework.widget.ui.NetworkImage
import com.bumptech.glide.Glide

internal class NetworkImageViewRenderer (
    private val image: NetworkImage,
    private val viewFactory: ViewFactory = ViewFactory(),
    private val viewMapper: ViewMapper = ViewMapper()
) : UIViewRenderer {

    override fun build(rootView: RootView): View {
        return viewFactory.makeImageView(rootView.getContext()).apply {
            val contentMode = image.contentMode ?: ImageContentMode.FIT_CENTER
            scaleType = viewMapper.toScaleType(contentMode)
            Glide.with(this).load(image.url).into(this)
        }
    }
}
