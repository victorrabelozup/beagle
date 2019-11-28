package br.com.zup.beagleui.framework.view

import android.content.Context
import androidx.appcompat.widget.AppCompatButton
import br.com.zup.beagleui.framework.state.Observable
import br.com.zup.beagleui.framework.interfaces.OnStateUpdatable
import br.com.zup.beagleui.framework.interfaces.StateChangeable
import br.com.zup.beagleui.framework.interfaces.WidgetState
import br.com.zup.beagleui.framework.utils.setData
import br.com.zup.beagleui.framework.widget.ui.Button as ButtonWidget

internal class BeagleButtonView(context: Context) : AppCompatButton(context),
    OnStateUpdatable<ButtonWidget>, StateChangeable {

    init {
        setOnClickListener {
            stateObservable.notifyObservers(WidgetState(Any()))
        }
    }

    private val stateObservable = Observable<WidgetState>()

    override fun getState(): Observable<WidgetState> = stateObservable

    override fun onUpdateState(widget: ButtonWidget) {
        this.setData(widget)
    }
}