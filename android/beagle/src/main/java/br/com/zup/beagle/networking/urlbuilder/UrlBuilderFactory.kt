/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.networking.urlbuilder

import br.com.zup.beagle.setup.BeagleEnvironment

internal class UrlBuilderFactory {
    fun make(): UrlBuilder {
        return BeagleEnvironment.beagleSdk.urlBuilder ?: UrlBuilderDefault()
    }
}