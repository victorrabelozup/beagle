package br.com.zup.beagleui.framework.widget.navigation

import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget

enum class NavigatorEventType {
    OPEN_DEEP_LINK,
    ADD_VIEW,
    OPEN_VIEW,
    FINISH_VIEW,
    POP_VIEW
}

data class NavigatorData(
    val path: String,
    val data: Map<String, String>? = null
)

data class Navigator(
    val type: NavigatorEventType,
    val value: NavigatorData? = null,
    val child: Widget
) : NativeWidget