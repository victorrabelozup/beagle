package br.com.zup.beagle.state

import android.view.View
import br.com.zup.beagle.interfaces.OnStateUpdatable
import br.com.zup.beagle.interfaces.StateChangeable
import br.com.zup.beagle.interfaces.WidgetState
import br.com.zup.beagle.utils.findChildViewForUpdatableWidgetId
import br.com.zup.beagle.utils.setNotFinalAndAccessible
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.DynamicState
import br.com.zup.beagle.widget.layout.UpdatableState
import br.com.zup.beagle.widget.layout.UpdatableWidget

internal class StatefulDynamicHelper {

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