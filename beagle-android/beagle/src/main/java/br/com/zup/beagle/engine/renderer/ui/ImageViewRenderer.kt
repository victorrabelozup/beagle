package br.com.zup.beagle.engine.renderer.ui

import android.view.View
import br.com.zup.beagle.engine.mapper.ViewMapper
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.utils.setData
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ui.Image

internal class ImageViewRenderer(
    override val component: Image,
    private val viewFactory: ViewFactory = ViewFactory(),
    private val viewMapper: ViewMapper = ViewMapper()
) : UIViewRenderer<Image>() {

    override fun buildView(rootView: RootView): View {
        return viewFactory.makeImageView(rootView.getContext()).apply {
            this.setData(component, viewMapper)
        }
    }
}
