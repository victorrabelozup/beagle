package br.com.zup.beagle.view

import android.content.Context
import androidx.appcompat.widget.AppCompatButton
import br.com.zup.beagle.engine.renderer.ui.setData
import br.com.zup.beagle.interfaces.OnStateUpdatable
import br.com.zup.beagle.interfaces.StateChangeable
import br.com.zup.beagle.interfaces.WidgetState
import br.com.zup.beagle.state.Observable
import br.com.zup.beagle.widget.ui.Button as ButtonWidget

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