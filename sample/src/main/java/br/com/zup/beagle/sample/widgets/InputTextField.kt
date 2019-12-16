package br.com.zup.beagleui.sample.widgets

import br.com.zup.beagle.sample.widgets.TextFieldInputType
import br.com.zup.beagle.widget.form.InputWidget


data class InputTextField(
    val id: String? = null,
    val description: String = "",
    val hint: String = "",
    val color: String = "#000000",
    val mask: String? = null,
    val inputType: TextFieldInputType? = null
) : InputWidget
