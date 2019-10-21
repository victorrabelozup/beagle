package br.com.zup.beagleui.framework.widget.navigation

import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget

data class Event(
    val type: EventType,
    val value: DeeplinkURL? = null
)

data class DeeplinkURL(
    val path: String,
    val data: Map<String, String>? = null
)

enum class EventType {
    OPEN_DEEP_LINK,
    ADD_VIEW,
    OPEN_VIEW,
    FINISH_VIEW,
    POP_VIEW
}

data class Navigator(
    val event: Event,
    val child: Widget
) : NativeWidget