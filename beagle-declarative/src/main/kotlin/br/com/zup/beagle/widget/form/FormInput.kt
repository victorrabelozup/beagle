package br.com.zup.beagle.widget.form

import br.com.zup.beagle.widget.core.Widget

data class FormInput(
    val name: String,
    val required: Boolean? = null,
    val validator: String? = null,
    val errorMessage: String? = null,
    val child: InputWidget
) : Widget