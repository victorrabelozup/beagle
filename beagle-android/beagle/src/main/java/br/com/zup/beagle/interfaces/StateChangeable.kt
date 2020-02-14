package br.com.zup.beagle.interfaces

import br.com.zup.beagle.state.Observable

interface StateChangeable {
    fun getState(): Observable<WidgetState>
}

data class WidgetState(val value: Any)