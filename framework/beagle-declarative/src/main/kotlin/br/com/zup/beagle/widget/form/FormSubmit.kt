package br.com.zup.beagle.widget.form

import br.com.zup.beagle.core.ServerDrivenComponent

data class FormSubmit(
    val child: ServerDrivenComponent,
    val enabled: Boolean = true
) : ServerDrivenComponent