package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.widget.core.Appearance
import br.com.zup.beagle.widget.core.AppearanceWidget
import br.com.zup.beagle.widget.core.Flex
import br.com.zup.beagle.widget.core.Widget

data class FlexWidget(
    val flex: Flex? = null,
    val children: List<Widget>,
    override val appearance: Appearance? = null
) : Widget, AppearanceWidget
