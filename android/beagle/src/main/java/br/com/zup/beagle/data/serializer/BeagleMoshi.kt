/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.data.serializer

import br.com.zup.beagle.data.serializer.adapter.ActionJsonAdapterFactory
import br.com.zup.beagle.data.serializer.adapter.AndroidFrameworkIgnoreAdapterFactory
import br.com.zup.beagle.data.serializer.adapter.ComponentJsonAdapterFactory
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory

internal object BeagleMoshi {

    val moshi: Moshi by lazy {
        Moshi.Builder()
            .add(AndroidFrameworkIgnoreAdapterFactory())
            .add(ComponentJsonAdapterFactory.make())
            .add(ActionJsonAdapterFactory.make())
            .add(KotlinJsonAdapterFactory())
            .build()
    }
}
