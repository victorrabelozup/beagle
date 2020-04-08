/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.micronaut.configuration

import br.com.zup.beagle.cache.BeagleCacheHandler
import br.com.zup.beagle.constants.BEAGLE_CACHE_EXCLUDES
import io.micronaut.context.annotation.Factory
import io.micronaut.context.annotation.Value
import javax.inject.Singleton

@Factory
class BeagleCacheConfiguration(@Value("\${$BEAGLE_CACHE_EXCLUDES:}") private val excludeEndpoints: List<String>) {
    @Singleton
    fun beagleCacheHandler() = BeagleCacheHandler(this.excludeEndpoints)
}