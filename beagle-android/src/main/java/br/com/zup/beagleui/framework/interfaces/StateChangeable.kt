package br.com.zup.beagleui.framework.interfaces

import br.com.zup.beagleui.framework.state.Observable

interface StateChangeable {
    fun getState(): Observable<WidgetState>
}

data class WidgetState(val value: Any)