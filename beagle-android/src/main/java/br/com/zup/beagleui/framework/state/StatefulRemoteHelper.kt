package br.com.zup.beagleui.framework.state

import android.view.View
import br.com.zup.beagleui.framework.engine.renderer.RootView
import br.com.zup.beagleui.framework.interfaces.StateChangeable
import br.com.zup.beagleui.framework.interfaces.WidgetState
import br.com.zup.beagleui.framework.utils.findChildViewForUpdatableWidgetId
import br.com.zup.beagleui.framework.utils.findUrlExpressions
import br.com.zup.beagleui.framework.utils.setNotFinalAndAccessible
import br.com.zup.beagleui.framework.view.BeagleView
import br.com.zup.beagleui.framework.widget.layout.RemoteUpdatableWidget
import br.com.zup.beagleui.framework.widget.layout.UpdatableState
import br.com.zup.beagleui.framework.widget.layout.UpdatableWidget
import java.net.MalformedURLException

internal class StatefulRemoteHelper {

    fun handleRemoteState(
        targetView: View,
        updatableState: UpdatableState,
        children: List<View>,
        rootView: RootView
    ) {
        val targetViewWidget = (targetView.tag as UpdatableWidget)
        updatableState.remoteState?.let {

            var stringUrl = (targetViewWidget.child as? RemoteUpdatableWidget)?.url

            val urlExpressions = stringUrl?.findUrlExpressions()
            urlExpressions?.forEach { expression ->
                val originView = children.findChildViewForUpdatableWidgetId(expression.expressionId)

                getCurrentState(originView)
                    ?.let { originViewWidgetState ->
                        stringUrl = replaceUrlExpression(
                            originViewWidgetState,
                            expression,
                            stringUrl
                        )
                    }
            }
            stringUrl?.apply {
                notifyState(targetView, rootView, this)
            }
        }
    }

    @Suppress("UNCHECKED_CAST")
    private fun notifyState(
        targetView: View,
        rootView: RootView,
        stringUrl: String
    ) {
        (targetView as? BeagleView)?.loadView(
            rootView,
            stringUrl
        )
    }

    @Suppress("UNCHECKED_CAST")
    private fun replaceUrlExpression(
        originViewWidgetState: WidgetState,
        expression: UrlExpression,
        stringUrl: String?
    ): String? {
        stringUrl?.let {
            val stateValueField =
                originViewWidgetState.javaClass.getDeclaredField(
                    removeExpressionCharacters(expression.expressionProperty)
                )
            stateValueField.setNotFinalAndAccessible()
            val stateValue = stateValueField.get(originViewWidgetState)
            return setExpressionValue(stringUrl, expression.originalExpression, stateValue)
        }

        throw MalformedURLException("Error replacing url expression for url: $stringUrl")
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