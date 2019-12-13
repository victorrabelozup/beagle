package br.com.zup.beagle.state

import android.view.View
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.interfaces.WidgetState
import br.com.zup.beagle.utils.findChildViewForUpdatableWidgetId
import br.com.zup.beagle.widget.layout.UpdatableState

internal const val THIS_ID = "this"

internal class StatefulRendererHelper(
    private val statefulRemoteHelper: StatefulRemoteHelper = StatefulRemoteHelper(),
    private val statefulDynamicHelper: StatefulDynamicHelper = StatefulDynamicHelper(),
    private val statefulStaticHelper: StatefulStaticHelper = StatefulStaticHelper()
) {

    @Suppress("UNCHECKED_CAST")
    fun handleStateChange(
        updatableState: UpdatableState,
        children: List<View>,
        rootView: RootView,
        currentWidgetState: WidgetState? = null
    ) {
        val targetView = children.findChildViewForUpdatableWidgetId(updatableState.targetId)

        targetView?.let { targetView ->
            if (updatableState.remoteState != null && currentWidgetState != null) {
                statefulRemoteHelper.handleRemoteState(
                    targetView,
                    updatableState,
                    children,
                    rootView
                )
            } else if (updatableState.dynamicState != null && currentWidgetState != null) {
                statefulDynamicHelper.handleDynamicState(
                    targetView,
                    updatableState,
                    currentWidgetState,
                    children
                )
            } else {
                statefulStaticHelper.notifyStaticState(updatableState, targetView)
            }
        }
    }

}