/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.utils

import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

internal object CoroutineDispatchers {

    init {
        reset()
    }

    lateinit var IO: CoroutineDispatcher
    lateinit var Main: CoroutineDispatcher
    lateinit var Default: CoroutineDispatcher

    fun reset() {
        IO = Dispatchers.IO
        Main = Dispatchers.Main
        Default = Dispatchers.Default
    }
}