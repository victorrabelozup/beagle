/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample

import android.content.Context
import br.com.zup.beagle.action.ActionListener
import br.com.zup.beagle.action.CustomAction
import br.com.zup.beagle.action.CustomActionHandler
import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.NavigationType
import br.com.zup.beagle.annotation.BeagleComponent
import br.com.zup.beagle.widget.layout.NavigationBar
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.ui.Text
import java.lang.Thread.sleep

@BeagleComponent
class AppCustomActionHandler : CustomActionHandler {

    override fun handle(context: Context, action: CustomAction, listener: ActionListener) {
        listener.onStart()
        when (action.name) {
            "formAsyncSubmit" -> Thread().run {
                print("I'm doing something clever here")
                sleep(3000)
                listener.onSuccess(Navigate(
                    type = NavigationType.ADD_VIEW,
                    screen = Screen(
                        child = Text("Testing CustomAction"),
                        navigationBar = NavigationBar(title = "After CustomAction")
                    )
                ))
            }
        }
        print("Custom Action executed")
    }
}