package br.com.zup.beagleui.framework.testutil

import br.com.zup.beagleui.framework.utils.CoroutineDispatchers
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