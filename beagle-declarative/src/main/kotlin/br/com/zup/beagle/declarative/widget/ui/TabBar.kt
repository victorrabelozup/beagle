package br.com.zup.beagle.declarative.widget.ui

import br.com.zup.beagle.declarative.widget.core.Widget

data class TabBar(
    val titles: List<String>,
    val contents: List<Widget>
) : Widget
