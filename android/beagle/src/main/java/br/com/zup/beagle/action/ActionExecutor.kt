/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.action

import android.content.Context
import br.com.zup.beagle.setup.BeagleEnvironment
import br.com.zup.beagle.view.BeagleActivity
import br.com.zup.beagle.view.ServerDrivenState

internal class ActionExecutor(
    private val customActionHandler: CustomActionHandler? =
        BeagleEnvironment.beagleSdk.customActionHandler,
    private val navigationActionHandler: NavigationActionHandler =
        NavigationActionHandler(),
    private val showNativeDialogActionHandler: ShowNativeDialogActionHandler =
        ShowNativeDialogActionHandler(),
    private val formValidationActionHandler: DefaultActionHandler<FormValidation>? = null
) {

    fun doAction(context: Context, action: Action?) {
        when (action) {
            is Navigate -> navigationActionHandler.handle(context, action)
            is ShowNativeDialog -> showNativeDialogActionHandler.handle(context, action)
            is FormValidation -> formValidationActionHandler?.handle(context, action)

            is CustomAction -> customActionHandler?.handle(context, action, object : ActionListener {

                override fun onSuccess(action: Action) {
                    changeActivityState(context, ServerDrivenState.Loading(false))
                    doAction(context, action)
                }

                override fun onError(e: Throwable) {
                    changeActivityState(context, ServerDrivenState.Loading(false))
                    changeActivityState(context, ServerDrivenState.Error(e))
                }

                override fun onStart() {
                    changeActivityState(context, ServerDrivenState.Loading(true))
                }
            })
        }
    }

    private fun changeActivityState(context: Context, state: ServerDrivenState) {
        (context as? BeagleActivity)?.onServerDrivenContainerStateChanged(state)
    }
}

