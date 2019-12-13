package br.com.zup.beagle.form

interface Validator {
    fun isValid(input: Any): Boolean
}

interface ValidationErrorListener {
    fun onValidationError(message: String?)
}