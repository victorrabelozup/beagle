package br.com.zup.beagle.widget.navigation

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.core.GhostComponent
import br.com.zup.beagle.core.ServerDrivenComponent

data class Touchable(
    val action: Action,
    override val child: ServerDrivenComponent
) : ServerDrivenComponent, GhostComponent
