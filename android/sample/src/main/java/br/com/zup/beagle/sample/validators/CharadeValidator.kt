/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.validators

import br.com.zup.beagle.annotation.RegisterValidator
import br.com.zup.beagle.form.Validator
import br.com.zup.beagle.sample.widgets.TextField
import java.util.Locale

@RegisterValidator("Charade")
class CharadeValidator : Validator<String, TextField> {
    override fun isValid(input: String, widget: TextField): Boolean {
        return input.toLowerCase(Locale.getDefault()) == "mary"
    }
}