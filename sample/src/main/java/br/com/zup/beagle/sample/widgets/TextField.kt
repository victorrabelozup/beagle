package br.com.zup.beagle.sample.widgets

import br.com.zup.beagle.annotation.RegisterWidget
import br.com.zup.beagle.widget.form.InputWidget
import android.content.Context
import android.graphics.Color
import android.text.InputType
import android.widget.EditText
import androidx.core.widget.doOnTextChanged
import br.com.zup.beagle.interfaces.StateChangeable
import br.com.zup.beagle.interfaces.WidgetState
import br.com.zup.beagle.sample.utils.MaskApplier
import br.com.zup.beagle.state.Observable

enum class TextFieldInputType {
    NUMBER,
    PASSWORD,
    TEXT
}

@RegisterWidget
data class TextField(
    val id: String? = null,
    val description: String = "",
    val hint: String = "",
    val color: String = "#000000",
    val mask: String? = null,
    val inputType: TextFieldInputType? = null
) : InputWidget, StateChangeable {

    private val stateObservable = Observable<WidgetState>()

    override fun getState(): Observable<WidgetState> = stateObservable

    private lateinit var textFieldView: EditText

    override fun toView(context: Context) = EditText(context).apply {
        textFieldView = this
        bind()

        this.doOnTextChanged { text, _, _, _ ->
            stateObservable.notifyObservers(WidgetState(text.toString()))
        }
    }

    override fun onErrorMessage(message: String) {
        textFieldView.error = message
    }

    override fun getValue(): Any = textFieldView.text

    private fun bind() {
        val color = Color.parseColor(color)
        textFieldView.setText(description)
        textFieldView.setTextColor(color)
        textFieldView.hint = hint
        textFieldView.setTextColor(color)
        textFieldView.setHintTextColor(color)

        inputType?.let {
            if (it == TextFieldInputType.NUMBER) {
                textFieldView.inputType = InputType.TYPE_CLASS_NUMBER or
                        InputType.TYPE_NUMBER_FLAG_SIGNED
            } else if (it == TextFieldInputType.PASSWORD) {
                textFieldView.inputType = InputType.TYPE_CLASS_TEXT or
                        InputType.TYPE_TEXT_VARIATION_PASSWORD
            }
        }

        mask?.let {
            MaskApplier(textFieldView, it)
        }
    }
}
