package br.com.zup.beagleui.framework.form

interface ValidatorHandler {
    fun getValidator(name: String): Validator?
}