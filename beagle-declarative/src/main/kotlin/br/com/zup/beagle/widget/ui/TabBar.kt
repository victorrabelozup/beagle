package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.widget.core.Widget

data class TabBar(
    val titles: List<String>,
    val contents: List<Widget>
) : Widget
