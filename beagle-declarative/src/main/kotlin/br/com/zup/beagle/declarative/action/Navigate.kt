package br.com.zup.beagle.declarative.action

enum class NavigationType {
    OPEN_DEEP_LINK,
    ADD_VIEW,
    SWAP_VIEW,
    FINISH_VIEW,
    POP_VIEW,
    POP_TO_VIEW,
    PRESENT_VIEW
}

data class Navigate(
    val type: NavigationType,
    val path: String? = null,
    val data: Map<String, String>? = null
) : Action