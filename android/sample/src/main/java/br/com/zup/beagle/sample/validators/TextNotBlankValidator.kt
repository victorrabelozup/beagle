package br.com.zup.beagle.sample.validators

import br.com.zup.beagle.annotation.RegisterValidator
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.form.Validator

@RegisterValidator("text-is-not-blank")
class TextNotBlankValidator : Validator<String, ServerDrivenComponent> {
    override fun isValid(input: String, widget: ServerDrivenComponent): Boolean {
        return !input.isBlank()
    }
}