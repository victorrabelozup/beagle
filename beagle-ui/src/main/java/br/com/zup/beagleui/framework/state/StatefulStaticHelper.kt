package br.com.zup.beagleui.framework.state

import android.view.View
import br.com.zup.beagleui.framework.interfaces.OnStateUpdatable
import br.com.zup.beagleui.framework.widget.core.Widget
import br.com.zup.beagleui.framework.widget.layout.UpdatableState

class StatefulStaticHelper {

    @Suppress("UNCHECKED_CAST")
    fun notifyStaticState(
        updatableState: UpdatableState,
        targetView: View
    ) {
        updatableState.staticState?.let { staticState ->
            (targetView as? OnStateUpdatable<Widget>)?.onUpdateState(staticState)
        }
    }

}