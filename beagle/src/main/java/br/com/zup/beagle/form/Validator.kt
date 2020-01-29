package br.com.zup.beagle.form

interface Validator<in I, in W> {
    fun isValid(input: I, widget: W): Boolean
}

interface ValidationErrorListener {
    fun onValidationError(message: String?)
}