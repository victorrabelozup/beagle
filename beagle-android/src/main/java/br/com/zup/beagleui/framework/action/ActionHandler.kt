package br.com.zup.beagleui.framework.action

import android.content.Context

interface ActionHandler<T : Action> {
    fun handle(context: Context, action: T)
}