package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.core.Flex
import br.com.zup.beagleui.framework.widget.core.Widget

data class FlexSingleWidget(
    val flex: Flex = Flex(),
    val child: Widget
) : Widget
