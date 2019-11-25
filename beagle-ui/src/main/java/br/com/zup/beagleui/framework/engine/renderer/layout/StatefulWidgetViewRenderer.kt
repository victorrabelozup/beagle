package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.core.widget.addTextChangedListener
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.interfaces.OnStateUpdatable
import br.com.zup.beagleui.framework.utils.findChildViewForType
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.StatefulWidget
import br.com.zup.beagleui.framework.widget.layout.UpdatableEvent
import br.com.zup.beagleui.framework.widget.layout.UpdatableState
import br.com.zup.beagleui.framework.widget.layout.UpdatableStateType
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget
import java.util.Observable

internal class StatefulWidgetViewRenderer(
    private val statefulWidget: StatefulWidget,
    viewRendererFactory: ViewRendererFactory = ViewRendererFactory(),
    viewFactory: ViewFactory = ViewFactory()
) : LayoutViewRenderer(viewRendererFactory, viewFactory) {

    private var elementList = mutableListOf<View>()

    override fun build(context: Context): View {
        val view = viewRendererFactory.make(statefulWidget.child).build(context)

        if (view is ViewGroup) {
            elementList = view.findChildViewForType(UpdatableWidget::class.java)
        }

        addEventHandler(elementList)

        return view
    }

    private fun addEventHandler(elementList: List<View>) {
        elementList.forEach { element ->
            addEventHandler(element, elementList)
        }
    }

    private fun addEventHandler(
        view: View,
        children: List<View>
    ) {
        val updatableWidget = view.tag as UpdatableWidget
        var onClickObservable: Observable? = updatableWidget.updateStates?.hasOnClick {
            onClickObservable(view)
        }

        updatableWidget.updateStates?.forEach { updatableState ->
            when (updatableState.stateType) {
                UpdatableStateType.STATIC -> setupStaticHandler(
                    updatableState,
                    view,
                    children,
                    onClickObservable
                )
                UpdatableStateType.DYNAMIC -> setupDynamicHandler(updatableState, view, children)
            }
        }
    }

    private fun onClickObservable(view: View): Observable {
        return object : Observable() {
            init {
                view.setOnClickListener {
                    setChanged()
                    notifyObservers()
                }
            }
        }
    }

    private fun setupDynamicHandler(
        updatableState: UpdatableState,
        view: View,
        children: List<View>
    ) {
        //TODO implement the dynamic handler that should call the url and update the state based on response
    }

    private fun setupStaticHandler(
        updatableState: UpdatableState,
        view: View,
        children: List<View>,
        onClickObservable: Observable?
    ) {
        when (updatableState.updatableEvent) {
            UpdatableEvent.ON_TEXT_CHANGE -> if (view is TextView) {
                view.addTextChangedListener {
                    notifyUpdate(updatableState, children)
                }
            }
            UpdatableEvent.ON_CLICK -> {
                onClickObservable?.addObserver { _, _ ->
                    notifyUpdate(
                        updatableState,
                        children
                    )
                }
            }
        }
    }

    @Suppress("UNCHECKED_CAST")
    private fun notifyUpdate(
        updatableState: UpdatableState,
        children: List<View>
    ) {
        children.find { child ->
            (child.tag as UpdatableWidget).id == updatableState.targetId
        }.apply {
            (this as? OnStateUpdatable<Widget>)?.onUpdateState(updatableState.targetState)
        }
    }


    private inline fun <T> List<UpdatableState>.hasOnClick(action: () -> T): T? =
        when {
            this.filter { it.updatableEvent == UpdatableEvent.ON_CLICK }.any() -> action()
            else -> null
        }

}
