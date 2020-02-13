package br.com.zup.beagle.interfaces

import br.com.zup.beagle.core.ServerDrivenComponent

interface OnStateUpdatable<T : ServerDrivenComponent> {
    fun onUpdateState(widget: T)
}