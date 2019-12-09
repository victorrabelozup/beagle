package br.com.zup.beagleui.framework.widget.ui

import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget

data class TabBar(
    val titles: List<String>,
    val contents: List<Widget>
) : NativeWidget
