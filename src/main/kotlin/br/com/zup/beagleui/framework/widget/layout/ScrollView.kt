package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.core.Widget

data class ScrollView(
    val children: List<Widget>,
    val scrollDirection: ScrollAxis? = null,
    val scrollBarEnabled: Boolean? = null
) : Widget

enum class ScrollAxis {
    VERTICAL,
    HORIZONTAL
}
