package br.com.zup.beagle.form

interface ValidatorHandler {
    fun getValidator(name: String): Validator?
}