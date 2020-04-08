/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.micronaut.service

import br.com.zup.beagle.sample.builder.LazyComponentScreenBuilder
import br.com.zup.beagle.widget.ui.Text
import javax.inject.Singleton

@Singleton
class SampleLazyComponentService {
    fun createLazyComponent() = LazyComponentScreenBuilder

    fun createTextLazyComponent() = Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do " +
        "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud" +
        " exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in " +
        "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat " +
        "cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
}
