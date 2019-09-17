package br.com.zup.beagleui.framework.engine.renderer.ui

import br.com.zup.beagleui.framework.widget.ui.Image
import br.com.zup.beagleui.framework.engine.renderer.ComponentRenderer
import com.facebook.drawee.backends.pipeline.Fresco
import com.facebook.litho.Component
import com.facebook.litho.ComponentContext
import com.facebook.litho.fresco.FrescoImage

class ImageComponentRenderer(
    private val image: Image
) : ComponentRenderer {

    override fun build(context: ComponentContext): Component {
        val controller = Fresco.newDraweeControllerBuilder()
            .setUri(image.path)
            .build()

        return FrescoImage.Builder()
            .controller(controller)
            .build()
    }
}
