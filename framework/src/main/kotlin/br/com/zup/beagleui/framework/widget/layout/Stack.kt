package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.Widget

data class Stack(
    val flex: Flex? = null,
    val children: List<Widget>
) : NativeWidget()