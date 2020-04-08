/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.micronaut.configuration

import br.com.zup.beagle.serialization.jackson.BeagleModule
import io.micronaut.context.annotation.Factory
import io.micronaut.context.annotation.Requires
import javax.inject.Singleton

@Factory
@Requires(classes = [BeagleModule::class])
class BeagleJacksonConfiguration {
    @Singleton
    fun beagleModule() = BeagleModule
}