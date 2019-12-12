package br.com.zup.beagleui.framework.interfaces

import br.com.zup.beagleui.framework.state.Observable

interface Observer<T> {
    fun update(o: Observable<T>, arg: T)
}