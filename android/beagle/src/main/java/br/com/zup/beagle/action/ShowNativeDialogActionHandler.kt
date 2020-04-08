/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.action

import android.content.Context
import br.com.zup.beagle.view.ViewFactory

internal class ShowNativeDialogActionHandler(
    private val viewFactory: ViewFactory = ViewFactory()
) : DefaultActionHandler<ShowNativeDialog> {

    override fun handle(context: Context, action: ShowNativeDialog) {
        viewFactory.makeAlertDialogBuilder(context)
            .setTitle(action.title)
            .setMessage(action.message)
            .setPositiveButton(action.buttonText) { dialog, _ ->
                dialog.dismiss()
            }.show()
    }
}
