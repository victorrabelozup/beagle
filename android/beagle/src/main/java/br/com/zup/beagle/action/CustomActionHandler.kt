/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.action

import android.content.Context

interface CustomActionHandler : ActionHandler<CustomAction> {
    fun handle(context: Context, action: CustomAction, listener: ActionListener)
}

interface DefaultActionHandler<T : Action> {
    fun handle(context: Context, action: T)
}

interface ActionListener {
    fun onError(e: Throwable)
    fun onSuccess(action: Action)
    fun onStart()
}