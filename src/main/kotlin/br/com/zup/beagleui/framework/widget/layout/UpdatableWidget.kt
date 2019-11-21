package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget

data class UpdatableWidget(
    val updateIds: List<String>? = null,
    val child: Widget,
    val updatableEvent: UpdatableEvent? = null,
    val id: String? = null
) : NativeWidget

enum class UpdatableEvent {
    ON_TEXT_CHANGE,
    ON_CLICK
}