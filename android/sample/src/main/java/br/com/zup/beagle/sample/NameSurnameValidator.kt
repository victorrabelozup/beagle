/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample

import br.com.zup.beagle.annotation.RegisterValidator
import br.com.zup.beagle.form.Validator
import br.com.zup.beagle.sample.widgets.TextField

@RegisterValidator("nameSurname")
class NameSurnameValidator : Validator<String, TextField> {

    override fun isValid(input: String, widget: TextField): Boolean =
        input.split(" ").size > 2
}