package br.com.zup.beagle.engine.renderer.ui

import android.view.View
import br.com.zup.beagle.action.ActionExecutor
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.UIViewRenderer
import br.com.zup.beagle.utils.setData
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.ui.Button

internal class ButtonViewRenderer(
    override val widget: Button,
    private val viewFactory: ViewFactory = ViewFactory(),
    private val actionExecutor: ActionExecutor = ActionExecutor()
) : UIViewRenderer<Button>() {

    override fun buildView(rootView: RootView): View {
        return viewFactory.makeButton(rootView.getContext()).apply {
            this.setOnClickListener { actionExecutor.doAction(context, widget.action) }
            this.setData(widget)
        }
    }
}