/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.testutil

import br.com.zup.beagle.utils.CoroutineDispatchers
import kotlinx.coroutines.Dispatchers
import org.junit.rules.TestRule
import org.junit.runner.Description
import org.junit.runners.model.Statement

class CoroutineTestRule : TestRule {

    override fun apply(base: Statement, description: Description?) = object : Statement() {
        @Throws(Throwable::class)
        override fun evaluate() {
            CoroutineDispatchers.Main = Dispatchers.Unconfined
            CoroutineDispatchers.IO = Dispatchers.Unconfined
            CoroutineDispatchers.Default = Dispatchers.Unconfined

            base.evaluate()

            CoroutineDispatchers.reset()
        }
    }
}