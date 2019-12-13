package br.com.zup.beagle.interfaces

import br.com.zup.beagle.state.Observable

interface Observer<T> {
    fun update(o: Observable<T>, arg: T)
}