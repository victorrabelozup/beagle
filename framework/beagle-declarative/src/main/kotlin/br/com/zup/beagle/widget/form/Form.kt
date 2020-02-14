package br.com.zup.beagle.widget.form

import br.com.zup.beagle.core.ServerDrivenComponent

enum class FormMethodType {
    GET,
    POST,
    PUT,
    DELETE
}

data class Form (
    val path: String,
    val method: FormMethodType,
    val child: ServerDrivenComponent
) : ServerDrivenComponent