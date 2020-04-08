/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample

import android.app.Application

class BeagleUiSampleApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        BeagleSetup().init(this)
    }
}
