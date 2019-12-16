package br.com.zup.beagle.engine.renderer

import br.com.zup.beagle.engine.renderer.layout.BuildableWidgetViewRenderer
import br.com.zup.beagle.engine.renderer.layout.FormInputViewRenderer
import br.com.zup.beagle.engine.renderer.layout.FormSubmitViewRenderer
import br.com.zup.beagle.engine.renderer.ui.ButtonViewRenderer
import br.com.zup.beagle.engine.renderer.ui.ImageViewRenderer
import br.com.zup.beagle.engine.renderer.ui.ListViewRenderer
import br.com.zup.beagle.engine.renderer.ui.CustomWidgetViewRenderer
import br.com.zup.beagle.engine.renderer.ui.NavigationBarViewRenderer
import br.com.zup.beagle.engine.renderer.ui.NetworkImageViewRenderer
import br.com.zup.beagle.engine.renderer.ui.PageIndicatorViewRenderer
import br.com.zup.beagle.engine.renderer.ui.TabViewRenderer
import br.com.zup.beagle.engine.renderer.ui.TextViewRenderer
import br.com.zup.beagle.widget.core.ComposeWidget
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.form.FormInput
import br.com.zup.beagle.widget.form.FormSubmit
import br.com.zup.beagle.widget.ui.Button
import br.com.zup.beagle.widget.ui.Image
import br.com.zup.beagle.widget.ui.ListView
import br.com.zup.beagle.widget.ui.NavigationBar
import br.com.zup.beagle.widget.ui.NetworkImage
import br.com.zup.beagle.widget.ui.PageIndicator
import br.com.zup.beagle.widget.ui.TabView
import br.com.zup.beagle.widget.ui.Text

internal class UIViewRendererFactory : AbstractViewRendererFactory {

    override fun make(widget: Widget): ViewRenderer {
        return if (widget is ComposeWidget) {
            BuildableWidgetViewRenderer(widget)
        } else {
            when (widget) {
                is Button -> ButtonViewRenderer(widget)
                is Text -> TextViewRenderer(widget)
                is Image -> ImageViewRenderer(widget)
                is NetworkImage -> NetworkImageViewRenderer(widget)
                is ListView -> ListViewRenderer(widget)
                is NavigationBar -> NavigationBarViewRenderer(widget)
                is FormInput -> FormInputViewRenderer(widget)
                is FormSubmit -> FormSubmitViewRenderer(widget)
                is PageIndicator -> PageIndicatorViewRenderer(widget)
                is TabView -> TabViewRenderer(widget)
                else -> CustomWidgetViewRenderer(widget)
            }
        }
    }
}