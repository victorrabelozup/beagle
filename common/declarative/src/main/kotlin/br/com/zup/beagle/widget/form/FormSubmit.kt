package br.com.zup.beagle.widget.form

import br.com.zup.beagle.core.GhostComponent
import br.com.zup.beagle.core.ServerDrivenComponent

data class FormSubmit(
    override val child: ServerDrivenComponent,
    val enabled: Boolean = true
) : ServerDrivenComponent, GhostComponent