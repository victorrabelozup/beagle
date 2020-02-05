package br.com.zup.beagle.engine.renderer.layout

import android.view.View
import br.com.zup.beagle.action.ActionExecutor
import br.com.zup.beagle.data.PreFetchHelper
import br.com.zup.beagle.engine.renderer.LayoutViewRenderer
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.view.ViewFactory
import br.com.zup.beagle.widget.navigation.Touchable

internal class TouchableViewRenderer(
    override val widget: Touchable,
    private val actionExecutor: ActionExecutor = ActionExecutor(),
    private val preFetchHelper: PreFetchHelper = PreFetchHelper(),
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer<Touchable>(viewRendererFactory, viewFactory) {

    override fun buildView(rootView: RootView): View {
        preFetchHelper.handlePreFetchWidget(rootView, widget.action)
        return viewRendererFactory.make(widget.child).build(rootView).apply {
            setOnClickListener { actionExecutor.doAction(context, widget.action) }
        }
    }
}
