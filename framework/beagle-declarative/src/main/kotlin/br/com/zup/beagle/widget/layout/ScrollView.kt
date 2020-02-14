package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.core.ServerDrivenComponent

data class ScrollView(
    val children: List<ServerDrivenComponent>,
    val scrollDirection: ScrollAxis? = null,
    val scrollBarEnabled: Boolean? = null
) : ServerDrivenComponent

enum class ScrollAxis {
    VERTICAL,
    HORIZONTAL
}
