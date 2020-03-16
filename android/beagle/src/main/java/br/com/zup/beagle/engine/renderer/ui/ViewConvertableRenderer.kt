package br.com.zup.beagle.engine.renderer.ui

import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.widget.core.ViewConvertable

internal class ViewConvertableRenderer(override val component: ViewConvertable) : UIViewRenderer<ViewConvertable>() {
    override fun buildView(rootView: RootView): View {
        return component.toView(rootView.getContext())
    }
}