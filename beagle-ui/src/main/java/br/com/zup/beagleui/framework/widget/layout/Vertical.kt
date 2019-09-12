package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.Widget

data class Vertical(
    val children: List<Widget>,
    val flex: Flex = Flex(),
    val reversed: Boolean = false
) : Widget
