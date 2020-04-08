/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.micronaut.service

import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.sample.builder.FormScreenBuilder
import javax.inject.Singleton

@Singleton
class SampleFormService {
    fun createFormView() = FormScreenBuilder

    fun submitForm(body: Map<String, String>) = ShowNativeDialog(
        title = "Success!",
        message = body.entries.joinToString(separator = "\n") { "${it.key}: ${it.value}" },
        buttonText = "Ok"
    )
}
