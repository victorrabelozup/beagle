package br.com.zup.beagle.action

import android.content.Context
import br.com.zup.beagle.logger.BeagleLogger
import br.com.zup.beagle.widget.form.FormInput

internal class FormValidationActionHandler : ActionHandler<FormValidation> {

    var formInputs: List<FormInput>? = null

    override fun handle(context: Context, action: FormValidation) {
        action.errors.forEach { error ->
            val formInput = formInputs?.find {
                it.name == error.inputName
            }

            formInput?.child?.onErrorMessage(error.message) ?:
                BeagleLogger.warning("Input name with name ${error.inputName} does " +
                        "not implement ValidationErrorListener")
        }
    }
}