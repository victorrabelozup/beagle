package br.com.zup.beagleui.framework.state

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.interfaces.StateChangeable
import br.com.zup.beagleui.framework.interfaces.WidgetState
import br.com.zup.beagleui.framework.utils.findChildViewForUpdatableWidgetId
import br.com.zup.beagleui.framework.utils.setNotFinalAndAccessible
import br.com.zup.beagleui.framework.view.BeagleView
import br.com.zup.beagleui.framework.widget.layout.UpdatableState
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget
import br.com.zup.beagleui.framework.widget.lazy.LazyWidget

private const val REGEX_EXPRESSION = "#\\{.*\\}"

internal class StatefulRemoteHelper {

    fun handleRemoteState(
        targetView: View,
        updatableState: UpdatableState,
        currentWidgetState: WidgetState,
        children: List<View>,
        rootView: RootView
    ) {
        val targetViewWidget = (targetView.tag as UpdatableWidget)
        updatableState.remoteState?.let { targetState ->
            val originId = targetState.originId

            if (originId == THIS_ID) {
                notifyState(currentWidgetState, targetViewWidget, targetView, rootView)
            } else {
                val originView = children.findChildViewForUpdatableWidgetId(originId)

                getCurrentState(originView)
                    ?.let { originViewWidgetState ->
                        notifyState(
                            originViewWidgetState,
                            targetViewWidget,
                            targetView,
                            rootView
                        )
                    }

            }
        }
    }

    @Suppress("UNCHECKED_CAST")
    private fun notifyState(
        originViewWidgetState: WidgetState,
        targetViewWidget: UpdatableWidget,
        targetView: View,
        rootView: RootView
    ) {
        val stringUrl = (targetViewWidget.child as? LazyWidget)?.url

        stringUrl?.let {
            val regex = REGEX_EXPRESSION.toRegex()
            val expressionFound = regex.find(stringUrl)?.value
            expressionFound?.let {
                val stateValueField =
                    originViewWidgetState.javaClass.getDeclaredField(
                        removeExpressionCharacters(it)
                    )
                stateValueField.setNotFinalAndAccessible()
                val stateValue = stateValueField.get(originViewWidgetState)
                (targetView as? BeagleView)?.loadView(
                    rootView,
                    setExpressionValue(stringUrl, expressionFound, stateValue)
                )
            }
        }
    }

    private fun setExpressionValue(
        stringUrl: String,
        expressionFound: String,
        stateValue: Any?
    ) = stringUrl.replaceFirst(expressionFound, "$stateValue")

    private fun removeExpressionCharacters(it: String) = it.replace("#", "")
        .replace("{", "").replace("}", "").trim()

    private fun getCurrentState(originView: View?) =
        (originView as? StateChangeable)?.getState()?.getCurrentValue()
}