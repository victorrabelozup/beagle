package br.com.zup.beagle.sample.validators

import br.com.zup.beagle.annotation.RegisterValidator
import br.com.zup.beagle.form.Validator
import br.com.zup.beagle.sample.widgets.TextField
import java.util.Locale

@RegisterValidator("Charade")
class CharadeValidator : Validator<String, TextField> {
    override fun isValid(input: String, widget: TextField): Boolean {
        return input.toLowerCase(Locale.getDefault()) == "mary"
    }
}