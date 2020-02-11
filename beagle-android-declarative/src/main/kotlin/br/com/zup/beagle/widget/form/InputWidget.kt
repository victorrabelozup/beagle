package br.com.zup.beagle.widget.form

import br.com.zup.beagle.widget.core.ViewConvertable

interface InputWidget : ViewConvertable {
    fun getValue(): Any
    fun onErrorMessage(message: String)
}