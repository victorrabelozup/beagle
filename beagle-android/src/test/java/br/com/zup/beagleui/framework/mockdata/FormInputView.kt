package br.com.zup.beagleui.framework.mockdata

import android.content.Context
import android.view.View
import br.com.zup.beagleui.framework.form.InputValue
import br.com.zup.beagleui.framework.form.ValidationErrorListener

class FormInputView(context: Context) : View(context), InputValue, ValidationErrorListener {
    override fun onValidationError(message: String?) {}

    override fun getValue(): String = ""
}

class FormInputViewWithoutValidation(context: Context) : View(context), InputValue {
    override fun getValue(): String = ""
}