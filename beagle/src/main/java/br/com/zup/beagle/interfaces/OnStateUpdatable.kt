package br.com.zup.beagle.interfaces

import br.com.zup.beagle.widget.core.Widget

interface OnStateUpdatable<T: Widget> {
    fun onUpdateState(widget: T)
}