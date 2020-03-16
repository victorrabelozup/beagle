package br.com.zup.beagle.form

interface ValidationErrorListener {
    fun onValidationError(message: String?)
}