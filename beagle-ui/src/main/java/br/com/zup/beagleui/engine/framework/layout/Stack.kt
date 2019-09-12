package br.com.zup.beagleui.engine.framework.layout

import br.com.zup.beagleui.engine.framework.core.Flex
import br.com.zup.beagleui.engine.framework.core.Widget

data class Stack(
    val children: List<Widget>,
    val flex: Flex? = null
) : Widget