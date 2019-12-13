package br.com.zup.beagle.mockdata

import android.content.Context
import android.view.View
import br.com.zup.beagle.form.InputValue
import br.com.zup.beagle.form.ValidationErrorListener

class FormInputView(context: Context) : View(context), InputValue, ValidationErrorListener {
    override fun onValidationError(message: String?) {}

    override fun getValue(): String = ""
}

class FormInputViewWithoutValidation(context: Context) : View(context), InputValue {
    override fun getValue(): String = ""
}