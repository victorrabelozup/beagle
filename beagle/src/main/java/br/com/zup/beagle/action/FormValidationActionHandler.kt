package br.com.zup.beagle.action

import android.content.Context
import android.view.View
import br.com.zup.beagle.form.ValidationErrorListener
import br.com.zup.beagle.logger.BeagleLogger
import br.com.zup.beagle.widget.form.FormInput

internal class FormValidationActionHandler : ActionHandler<FormValidation> {

    var formInputViews: List<View>? = null

    override fun handle(context: Context, action: FormValidation) {
        action.errors.forEach { error ->
            val validationListener = formInputViews?.find {
                val formInput = it.tag as FormInput
                formInput.name == error.inputName
            } as? ValidationErrorListener

            validationListener?.onValidationError(error.message) ?:
            BeagleLogger.warning("Input name with name ${error.inputName} does not implement ValidationErrorListener")
        }
    }
}