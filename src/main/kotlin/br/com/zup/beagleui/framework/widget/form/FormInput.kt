package br.com.zup.beagleui.framework.widget.form

import br.com.zup.beagleui.framework.widget.core.Widget

interface InputWidget : Widget

data class FormInput(
    val name: String,
    val required: Boolean? = null,
    val validator: String? = null,
    val errorMessage: String? = null,
    val child: InputWidget
) : Widget