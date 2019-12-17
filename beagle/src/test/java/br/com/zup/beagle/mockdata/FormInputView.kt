package br.com.zup.beagle.mockdata

import android.content.Context
import android.view.View
import br.com.zup.beagle.form.InputValue
import br.com.zup.beagle.form.ValidationErrorListener
import br.com.zup.beagle.view.WidgetViewFactory
import br.com.zup.beagle.widget.form.InputWidget

class FormInputView(context: Context) : View(context), InputValue, ValidationErrorListener {
    override fun onValidationError(message: String?) {}

    override fun getValue(): String = ""
}

class FormInputViewWithoutValidation(context: Context) : View(context), InputValue {
    override fun getValue(): String = ""
}

class FormInputViewFactory : WidgetViewFactory<CustomInputWidget> {
    override fun make(context: Context, widget: CustomInputWidget): View {
        return FormInputView(context)
    }

}

class CustomInputWidget : InputWidget