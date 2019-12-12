package br.com.zup.beagle.declarative.widget.form

import br.com.zup.beagle.declarative.widget.core.Widget

enum class FormMethodType {
    GET,
    POST,
    PUT,
    DELETE
}

data class Form (
    val action: String,
    val method: FormMethodType,
    val child: Widget
) : Widget