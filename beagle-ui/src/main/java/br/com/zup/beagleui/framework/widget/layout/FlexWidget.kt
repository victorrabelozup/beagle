package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.Widget

data class FlexWidget(
    val flex: Flex = Flex(),
    val children: List<Widget>
) : Widget
