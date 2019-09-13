package br.com.zup.beagleui.framework.layout

import br.com.zup.beagleui.framework.core.NativeWidget
import br.com.zup.beagleui.framework.core.Flex
import br.com.zup.beagleui.framework.core.Widget

data class Vertical(
    val flex: Flex? = null,
    val children: List<Widget>,
    val reversed: Boolean? = null
) : NativeWidget()
