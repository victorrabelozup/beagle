/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.state

import br.com.zup.beagle.interfaces.Observer
import java.util.Vector

class Observable<T> {
    private var changed = false
    private val obs: Vector<Observer<T>> = Vector()
    private var currentValue: T? = null

    @Synchronized
    fun addObserver(o: Observer<T>) {
        if (!obs.contains(o)) {
            obs.addElement(o)
        }

        if (hasChanged()) {
            currentValue?.let {
                notifyObservers(it)
            }
        }
    }

    @Synchronized
    fun deleteObserver(o: Observer<T>) {
        obs.removeElement(o)
    }

    fun notifyObservers(arg: T) {
        currentValue = arg
        setChanged()
        val arrLocal: Array<Any>

        synchronized(this) {
            if (!changed)
                return
            arrLocal = obs.toArray()
            clearChanged()
        }

        for (i in arrLocal.indices.reversed())
            (arrLocal[i] as Observer<T>).update(this, arg)
    }

    @Synchronized
    fun deleteObservers() {
        obs.removeAllElements()
    }

    @Synchronized
    protected fun setChanged() {
        changed = true
    }

    @Synchronized
    protected fun clearChanged() {
        changed = false
    }

    @Synchronized
    fun hasChanged(): Boolean {
        return changed
    }

    @Synchronized
    fun countObservers(): Int {
        return obs.size
    }

    @Synchronized
    fun getCurrentValue(): T? = currentValue
}