package br.com.zup.beagleui.framework.engine.renderer.layout

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.core.widget.addTextChangedListener
import br.com.zup.beagleui.framework.engine.renderer.LayoutViewRenderer
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.utils.findChildViewForType
import br.com.zup.beagleui.framework.view.ViewFactory
import br.com.zup.beagleui.framework.widget.layout.StatefulWidget
import br.com.zup.beagleui.framework.widget.layout.UpdatableEvent
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget

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

        addChildrenViews(elementList)

        return view
    }

    private fun addChildrenViews(elementList: List<View>) {
        elementList.forEach { element ->
            addEventHandler(element, elementList)
        }
    }

    private fun addEventHandler(
        view: View,
        children: List<View>
    ) {
        val updatableWidget = view.tag as UpdatableWidget
        updatableWidget.updatableEvent?.let {
            when {
                updatableWidget.updatableEvent == UpdatableEvent.ON_TEXT_CHANGE -> if (view is TextView) {
                    view.addTextChangedListener { charSequence ->
                        notifyIds(updatableWidget, children, charSequence.toString())
                    }
                }
                updatableWidget.updatableEvent == UpdatableEvent.ON_CLICK ->
                    view.setOnClickListener {
                        notifyIds(updatableWidget, children)
                    }
            }
        }
    }

    private fun notifyIds(
        updatableWidget: UpdatableWidget,
        children: List<View>,
        charSequence: String = ""
    ) {
        updatableWidget.updateIds?.let {
            it.forEach { updateId ->
                children.find { child ->
                    (child.tag as UpdatableWidget).id == updateId
                }.apply {
                    updateWidget(this?.tag as UpdatableWidget, charSequence)
                }
            }
        }

    }

    private fun updateWidget(updatableWidget: UpdatableWidget?, charSequence: String) {
        elementList.find { (it.tag as UpdatableWidget).id == updatableWidget?.id }
            .apply {
                when (val view = this) {
                    is TextView -> view.text = "UPDATED"
                }
            }
    }
}
