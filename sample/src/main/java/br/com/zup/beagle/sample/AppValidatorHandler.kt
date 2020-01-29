package br.com.zup.beagle.sample

import br.com.zup.beagle.form.Validator
import br.com.zup.beagle.form.ValidatorHandler
import br.com.zup.beagle.sample.validators.CharadeValidator

class AppValidatorHandler : ValidatorHandler {
    private val validators = mapOf(
        "Charade" to CharadeValidator()
    )

    override fun getValidator(name: String): Validator<Any?, Any?>? = validators[name] as Validator<Any?, Any?>
}
