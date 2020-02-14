package br.com.zup.beagle.sample

import br.com.zup.beagle.annotation.RegisterValidator
import br.com.zup.beagle.form.Validator
import br.com.zup.beagle.sample.widgets.TextField

@RegisterValidator("nameSurname")
class NameSurnameValidator : Validator<String, TextField> {

    override fun isValid(input: String, widget: TextField): Boolean =
        input.split(" ").size > 2
}