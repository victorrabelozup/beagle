package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Widget

data class UpdatableWidget(
    val child: Widget,
    val id: String? = null,
    val updateStates: List<UpdatableState>? = null
) : Widget

data class UpdatableState(val targetId: String,
                          val staticState: Widget? = null,
                          val dynamicState: DynamicState? = null,
                          val remoteState: RemoteState? = null)

data class DynamicState(val stateOriginField: String, val targetField: String, val originId: String)

class RemoteState