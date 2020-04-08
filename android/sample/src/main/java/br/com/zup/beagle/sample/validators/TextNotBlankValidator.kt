/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.validators

import br.com.zup.beagle.annotation.RegisterValidator
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.form.Validator

@RegisterValidator("text-is-not-blank")
class TextNotBlankValidator : Validator<String, ServerDrivenComponent> {
    override fun isValid(input: String, widget: ServerDrivenComponent): Boolean {
        return !input.isBlank()
    }
}