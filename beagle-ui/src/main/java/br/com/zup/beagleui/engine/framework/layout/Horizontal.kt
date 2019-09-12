package br.com.zup.beagleui.engine.framework.layout

import br.com.zup.beagleui.engine.framework.core.Flex
import br.com.zup.beagleui.engine.framework.core.Widget

data class Horizontal(
    val children: List<Widget>,
    val flex: Flex? = null,
    val reversed: Boolean? = null
) : Widget
