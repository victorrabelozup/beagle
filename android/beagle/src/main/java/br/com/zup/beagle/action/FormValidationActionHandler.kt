/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.action

import android.content.Context
import br.com.zup.beagle.logger.BeagleLogger
import br.com.zup.beagle.widget.form.FormInput
import br.com.zup.beagle.widget.form.InputWidget

internal class FormValidationActionHandler : DefaultActionHandler<FormValidation> {

    var formInputs: List<FormInput>? = null

    override fun handle(context: Context, action: FormValidation) {
        action.errors.forEach { error ->
            val formInput = formInputs?.find {
                it.name == error.inputName
            }
            val childInputWidget : InputWidget? = formInput?.child

            childInputWidget?.onErrorMessage(error.message) ?:
                BeagleLogger.warning("Input name with name ${error.inputName} does " +
                        "not implement ValidationErrorListener")
        }
    }
}