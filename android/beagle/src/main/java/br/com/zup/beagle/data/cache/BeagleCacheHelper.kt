/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.data.cache

import br.com.zup.beagle.core.ServerDrivenComponent

internal object BeagleCacheHelper {
    private val cacheMap = mutableMapOf<String, ServerDrivenComponent>()

    fun cache(
        url: String,
        obj: ServerDrivenComponent
    ): ServerDrivenComponent {
        cacheMap[url] = obj

        return obj
    }

    fun getFromCache(url: String) = cacheMap.containsKey(url).let {
        cacheMap[url]
    }
}