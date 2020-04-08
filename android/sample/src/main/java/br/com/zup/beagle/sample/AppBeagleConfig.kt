/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample

import br.com.zup.beagle.annotation.BeagleComponent
import br.com.zup.beagle.sample.constants.BASE_URL
import br.com.zup.beagle.setup.BeagleConfig
import br.com.zup.beagle.setup.Environment

@BeagleComponent
class AppBeagleConfig : BeagleConfig {
    override val environment: Environment get() = Environment.DEBUG
    override val baseUrl: String get() = BASE_URL
}