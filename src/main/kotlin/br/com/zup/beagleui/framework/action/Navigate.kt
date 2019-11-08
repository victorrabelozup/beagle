package br.com.zup.beagleui.framework.action

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

data class Navigate(
    val type: NavigatorEventType? = null /* = NavigatorEventType.ADD_VIEW */,
    val value: NavigatorData? = null
) : Action