package br.com.zup.beagleui.framework.state

import android.view.View
import br.com.zup.beagleui.framework.interfaces.OnStateUpdatable
import br.com.zup.beagleui.framework.interfaces.StateChangeable
import br.com.zup.beagleui.framework.interfaces.WidgetState
import br.com.zup.beagleui.framework.utils.findChildViewForUpdatableWidgetId
import br.com.zup.beagleui.framework.utils.setNotFinalAndAccessible
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.DynamicState
import br.com.zup.beagleui.framework.widget.layout.UpdatableState
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget

class StatefulDynamicHelper {

    fun handleDynamicState(
        targetView: View,
        updatableState: UpdatableState,
        widgetState: WidgetState,
        children: List<View>
    ) {
        val widget = (targetView.tag as UpdatableWidget).child
        updatableState.dynamicState?.let { targetDynamicState ->
            val originId = targetDynamicState.originId

            if (originId == THIS_ID) {
                notifyDynamicState(widgetState, targetDynamicState, widget, targetView)
            } else {
                val originView = children.findChildViewForUpdatableWidgetId(originId)

                getCurrentState(originView)
                    ?.let { currentWidgetState ->
                        notifyDynamicState(
                            currentWidgetState,
                            targetDynamicState,
                            widget,
                            targetView
                        )
                    }

            }
        }
    }

    @Suppress("UNCHECKED_CAST")
    private fun notifyDynamicState(
        currentWidgetState: WidgetState,
        targetState: DynamicState,
        widget: Widget,
        targetView: View
    ): Unit? {
        val stateValueField =
            currentWidgetState.javaClass.getDeclaredField(targetState.stateOriginField)
        stateValueField.setNotFinalAndAccessible()
        val stateValue = stateValueField.get(currentWidgetState)
        val widgetTargetField =
            widget.javaClass.getDeclaredField(targetState.targetField)
        widgetTargetField.setNotFinalAndAccessible()
        widgetTargetField.set(widget, stateValue)
        return (targetView as? OnStateUpdatable<Widget>)?.onUpdateState(widget)
    }

    private fun getCurrentState(originView: View?) =
        (originView as? StateChangeable)?.getState()?.getCurrentValue()
}