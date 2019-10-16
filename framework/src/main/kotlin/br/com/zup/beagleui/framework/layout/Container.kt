package br.com.zup.beagleui.framework.layout

import br.com.zup.beagleui.framework.core.NativeWidget
import br.com.zup.beagleui.framework.core.Widget

data class Container(
    val header: Widget? = null,
    val content: Widget,
    val footer: Widget? = null
) : NativeWidget()