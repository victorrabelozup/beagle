package br.com.zup.beagleui.framework.state

import br.com.zup.beagleui.framework.interfaces.Observer
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