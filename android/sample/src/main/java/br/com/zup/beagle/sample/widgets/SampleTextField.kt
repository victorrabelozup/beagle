package br.com.zup.beagle.sample.widgets

import android.content.Context
import android.widget.EditText
import br.com.zup.beagle.annotation.RegisterWidget
import br.com.zup.beagle.interfaces.StateChangeable
import br.com.zup.beagle.interfaces.WidgetState
import br.com.zup.beagle.state.Observable
import br.com.zup.beagle.widget.form.InputWidget
import androidx.core.widget.doOnTextChanged

@RegisterWidget
class SampleTextField(val placeholder: String) : InputWidget(), StateChangeable {

    @Transient
    private lateinit var textFieldView: EditText
    @Transient
    private val stateObservable = Observable<WidgetState>()

    override fun getState(): Observable<WidgetState> = stateObservable

    override fun getValue(): Any = textFieldView.text.toString()

    override fun onErrorMessage(message: String) {
        textFieldView.error = message
    }

    override fun toView(context: Context) = EditText(context).apply {
        textFieldView = this
        textFieldView.hint = placeholder
        textFieldView.isSingleLine = true
        this.doOnTextChanged { text, _, _, _ ->
            stateObservable.notifyObservers(WidgetState(text.toString()))
        }
    }
}