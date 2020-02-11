package br.com.zup.beagle.widget.ui

import br.com.zup.beagle.core.ServerDrivenComponent

data class TabBar(
    val titles: List<String>,
    val contents: List<ServerDrivenComponent>
) : ServerDrivenComponent
