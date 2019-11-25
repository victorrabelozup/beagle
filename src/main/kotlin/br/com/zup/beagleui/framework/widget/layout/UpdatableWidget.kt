package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget

data class UpdatableWidget(
    val child: Widget,
    val id: String? = null,
    val updateStates: List<UpdatableState>? = null
) : NativeWidget

enum class UpdatableEvent {
    ON_TEXT_CHANGE,
    ON_CLICK
}

data class UpdatableState(val stateType: UpdatableStateType, val targetState: Widget, val targetId: String, val updatableEvent: UpdatableEvent)

enum class UpdatableStateType {
    STATIC,
    DYNAMIC
}