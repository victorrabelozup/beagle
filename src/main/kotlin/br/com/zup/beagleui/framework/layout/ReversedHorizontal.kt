package br.com.zup.beagleui.framework.layout

import br.com.zup.beagleui.framework.core.DumbWidget
import br.com.zup.beagleui.framework.core.Flex
import br.com.zup.beagleui.framework.core.Widget

data class ReversedHorizontal(
    val flex: Flex = Flex(),
    val children: List<Widget>
) : DumbWidget()