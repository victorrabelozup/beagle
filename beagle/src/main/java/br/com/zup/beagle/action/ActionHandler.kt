package br.com.zup.beagle.action

import android.content.Context

interface ActionHandler<T : Action> {
    fun handle(context: Context, action: T)
}