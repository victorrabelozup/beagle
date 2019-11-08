package br.com.zup.beagleui.framework.action

enum class NavigationType {
    OPEN_DEEP_LINK,
    ADD_VIEW,
    OPEN_VIEW,
    FINISH_VIEW,
    POP_VIEW
}
data class Navigate(
    val type: NavigationType,
    val path: String? = null,
    val data: Map<String, String>? = null
) : Action