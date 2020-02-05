package br.com.zup.beagle.sample.widgets

import android.content.Context
import android.graphics.Color
import android.text.InputType
import android.widget.EditText
import br.com.zup.beagle.sample.utils.MaskApplier
import br.com.zup.beagle.widget.form.InputWidget

enum class TextFieldInputType {
    NUMBER,
    PASSWORD,
    TEXT
}

data class TextField(
    val id: String? = null,
    val description: String = "",
    val hint: String = "",
    val color: String = "#000000",
    val mask: String? = null,
    val inputType: TextFieldInputType? = null
) : InputWidget {

    private lateinit var textFieldView: EditText

    override fun toView(context: Context) = EditText(context).apply {
        textFieldView = this
        bind()
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
