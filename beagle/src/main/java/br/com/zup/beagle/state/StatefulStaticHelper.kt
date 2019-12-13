package br.com.zup.beagle.state

import android.view.View
import br.com.zup.beagle.interfaces.OnStateUpdatable
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.UpdatableState

internal class StatefulStaticHelper {

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