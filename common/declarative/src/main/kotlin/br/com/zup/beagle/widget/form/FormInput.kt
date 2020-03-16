package br.com.zup.beagle.widget.form

import br.com.zup.beagle.core.GhostComponent
import br.com.zup.beagle.core.ServerDrivenComponent

data class FormInput(
    val name: String,
    val required: Boolean? = null,
    val validator: String? = null,
    val errorMessage: String? = null,
    override val child: InputWidget
) : ServerDrivenComponent, GhostComponent