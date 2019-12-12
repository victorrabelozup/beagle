package br.com.zup.beagleui.framework.form

interface Validator {
    fun isValid(input: Any): Boolean
}

interface ValidationErrorListener {
    fun onValidationError(message: String?)
}