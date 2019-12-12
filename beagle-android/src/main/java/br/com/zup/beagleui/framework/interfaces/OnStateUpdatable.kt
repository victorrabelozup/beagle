package br.com.zup.beagleui.framework.interfaces

import br.com.zup.beagleui.framework.widget.core.Widget

interface OnStateUpdatable<T: Widget> {
    fun onUpdateState(widget: T)
}