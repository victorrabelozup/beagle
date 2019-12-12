package br.com.zup.beagle.declarative.widget.layout

import br.com.zup.beagle.declarative.widget.core.Widget

data class ScrollView(
    val children: List<Widget>,
    val scrollDirection: ScrollAxis? = null,
    val scrollBarEnabled: Boolean? = null
) : Widget

enum class ScrollAxis {
    VERTICAL,
    HORIZONTAL
}
