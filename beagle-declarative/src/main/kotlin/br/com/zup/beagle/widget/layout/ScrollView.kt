package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Appearance
import br.com.zup.beagle.widget.core.AppearanceWidget
import br.com.zup.beagle.widget.core.Widget

data class ScrollView(
    val children: List<Widget>,
    val scrollDirection: ScrollAxis? = null,
    val scrollBarEnabled: Boolean? = null,
    override val appearance: Appearance? = null
) : Widget, AppearanceWidget

enum class ScrollAxis {
    VERTICAL,
    HORIZONTAL
}
