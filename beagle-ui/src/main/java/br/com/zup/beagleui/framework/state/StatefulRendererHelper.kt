package br.com.zup.beagleui.framework.state

import android.view.View
import br.com.zup.beagleui.framework.interfaces.WidgetState
import br.com.zup.beagleui.framework.utils.findChildViewForUpdatableWidgetId
import br.com.zup.beagleui.framework.widget.layout.UpdatableState

internal const val THIS_ID = "this"

class StatefulRendererHelper(
    private val statefulDynamicHelper: StatefulDynamicHelper = StatefulDynamicHelper(),
    private val statefulStaticHelper: StatefulStaticHelper = StatefulStaticHelper()
) {

    @Suppress("UNCHECKED_CAST")
    fun handleStateChange(
        updatableState: UpdatableState,
        children: List<View>,
        dynamicWidgetState: WidgetState? = null
    ) {
        val targetView = children.findChildViewForUpdatableWidgetId(updatableState.targetId)

        targetView?.let { targetView ->
            if (updatableState.dynamicState != null && dynamicWidgetState != null) {
                statefulDynamicHelper.handleDynamicState(
                    targetView,
                    updatableState,
                    dynamicWidgetState,
                    children
                )
            } else {
                statefulStaticHelper.notifyStaticState(updatableState, targetView)
            }
        }
    }

}