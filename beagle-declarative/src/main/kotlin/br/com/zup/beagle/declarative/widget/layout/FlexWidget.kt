package br.com.zup.beagle.declarative.widget.layout

import br.com.zup.beagle.declarative.widget.core.Flex
import br.com.zup.beagle.declarative.widget.core.Widget

data class FlexWidget(
    val flex: Flex? = null,
    val children: List<Widget>
) : Widget
