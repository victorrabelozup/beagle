package br.com.zup.beagleui.framework.engine.renderer.layout

import android.view.View
import android.view.ViewGroup
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.interfaces.Observer
import br.com.zup.beagleui.framework.interfaces.StateChangeable
import br.com.zup.beagleui.framework.interfaces.WidgetState
import br.com.zup.beagleui.framework.state.Observable
import br.com.zup.beagleui.framework.state.StatefulRendererHelper
import br.com.zup.beagleui.framework.utils.findChildViewForType
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.layout.StatefulWidget
import br.com.zup.beagleui.framework.widget.layout.UpdatableState
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget

internal class StatefulWidgetViewRenderer(
    private val statefulWidget: StatefulWidget,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory(),
    private val statefulRendererHelper: StatefulRendererHelper = StatefulRendererHelper()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    private var elementList = mutableListOf<View>()

    override fun build(rootView: RootView): View {
        val view = viewRendererFactory.make(statefulWidget.child).build(rootView)

        if (view is ViewGroup) {
            elementList = view.findChildViewForType(UpdatableWidget::class.java)
        }

        addEventHandler(elementList, rootView)

        return view
    }

    private fun addEventHandler(elementList: List<View>, rootView: RootView) {
        elementList.forEach { element ->
            addEventHandler(element, elementList, rootView)
        }
    }

    private fun addEventHandler(
        view: View,
        children: List<View>,
        rootView: RootView
    ) {
        val updatableWidget = view.tag as UpdatableWidget
        updatableWidget.updateStates?.forEach { updatableState ->
            setupHandler(
                updatableState,
                view,
                children,
                rootView
            )
        }
    }

    private fun setupHandler(
        updatableState: UpdatableState,
        view: View,
        children: List<View>,
        rootView: RootView
    ) {

        if (view is StateChangeable) {
            view.getState().addObserver(object : Observer<WidgetState> {
                override fun update(
                    o: Observable<WidgetState>,
                    widgetState: WidgetState
                ) {
                    statefulRendererHelper.handleStateChange(updatableState, children, rootView, widgetState)
                }
            })
        }
    }
}
