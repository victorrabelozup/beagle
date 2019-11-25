package br.com.zup.beagleui.sample.widgets

import android.content.Context
import android.graphics.Color
import android.text.Editable
import android.text.InputType
import android.text.TextWatcher
import android.view.View
import android.widget.EditText
import br.com.zup.beagleui.framework.view.WidgetViewFactory

class TextFieldView(context: Context) : EditText(context) {

    fun bind(data: TextField) {

        val color = Color.parseColor(data.color)
        setText(data.description)
        setTextColor(color)
        tag = data.id
        hint = data.hint
        setTextColor(color)
        setHintTextColor(color)

        data.inputType?.let {
            if (it == TextFieldInputType.NUMBER) {
                inputType = InputType.TYPE_CLASS_NUMBER or
                        InputType.TYPE_NUMBER_FLAG_SIGNED
            } else if (it == TextFieldInputType.PASSWORD) {
                inputType = InputType.TYPE_CLASS_TEXT or
                        InputType.TYPE_TEXT_VARIATION_PASSWORD
            }
        }

        data.mask?.let {
            addTextChangedListener(MaskApplier(this, it))
        }
    }
}

class TextFieldViewFactory : WidgetViewFactory<TextField> {
    override fun make(context: Context, widget: TextField): View {
        return TextFieldView(context).apply {
            bind(widget)
        }
    }
}

class MaskApplier(
    private val editText: EditText,
    private val mask: String
) : TextWatcher {

    private var isUpdating: Boolean = false
    private var old = ""
    private var beforeEdit: String = ""
    private var afterEdit: String = ""

    override fun afterTextChanged(s: Editable?) {}

    override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
        beforeEdit = editText.text.toString()
    }

    override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
        afterEdit = editText.text.toString()
        if (beforeEdit.length <= afterEdit.length) {
            var selectionPlus = 0
            val selection = editText.selectionStart
            val str = unmask(s.toString())
            var mascara = ""
            if (isUpdating) {
                old = str
                isUpdating = false
                return
            }
            var i = 0
            for (m in mask.toCharArray()) {
                if (str.length + selectionPlus <= i)
                    break

                if (m == '#') {
                    mascara += str.get(i - selectionPlus)
                } else {
                    mascara += StringBuilder().append(m)
                    selectionPlus++
                }
                i++
            }
            isUpdating = true
            beforeEdit = mascara
            editText.setText(mascara)

            editText.setSelection(if (selection + selectionPlus > mascara.length) mascara.length else selection + selectionPlus)
        }
    }

    private fun unmask(s: String): String {
        return s.replace("[.]".toRegex(), "").replace("[-]".toRegex(), "")
            .replace("[/]".toRegex(), "").replace("[(]".toRegex(), "")
            .replace("[)]".toRegex(), "")
    }
}
