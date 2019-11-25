package br.com.zup.beagleui.sample.widgets

import br.com.zup.beagleui.framework.widget.core.NativeWidget

data class TextField(
    val id: String? = null,
    val description: String = "",
    val hint: String,
    val color: String,
    val mask: String? = null,
    val inputType: TextFieldInputType? = null
) : NativeWidget

enum class TextFieldInputType {
    NUMBER,
    PASSWORD,
    TEXT
}
