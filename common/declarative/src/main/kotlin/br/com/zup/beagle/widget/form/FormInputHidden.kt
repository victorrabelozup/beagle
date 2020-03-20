package br.com.zup.beagle.widget.form

import br.com.zup.beagle.core.ServerDrivenComponent

data class FormInputHidden(
    val name: String,
    val value: String
) : ServerDrivenComponent