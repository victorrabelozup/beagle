package br.com.zup.beagleui.framework.layout

import br.com.zup.beagleui.framework.core.NativeWidget
import br.com.zup.beagleui.framework.core.Flex
import br.com.zup.beagleui.framework.core.Widget

data class Stack(
    val flex: Flex? = null,
    val children: List<Widget>
) : NativeWidget()