package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.core.LayoutComponent
import br.com.zup.beagle.core.ServerDrivenComponent

data class ScrollView(
    val children: List<ServerDrivenComponent>,
    val scrollDirection: ScrollAxis? = null,
    val scrollBarEnabled: Boolean? = null
) : ServerDrivenComponent, LayoutComponent

enum class ScrollAxis {
    VERTICAL,
    HORIZONTAL
}
