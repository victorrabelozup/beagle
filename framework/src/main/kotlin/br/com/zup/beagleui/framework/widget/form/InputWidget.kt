package br.com.zup.beagleui.framework.widget.form

import br.com.zup.beagleui.framework.widget.core.NativeWidget

class InputWidget : NativeWidget()

data class FormInput(
    val name: String,
    val required: Boolean? = null,
    val validator: String? = null,
    val child: InputWidget
) : NativeWidget()