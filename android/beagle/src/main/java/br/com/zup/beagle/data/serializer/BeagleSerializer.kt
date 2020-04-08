/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.data.serializer

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.exception.BeagleException
import br.com.zup.beagle.logger.BeagleMessageLogs

private const val EXCEPTION_MESSAGE = "Unexpected error when trying to serialize json="

internal class BeagleSerializer(
    private val beagleMoshiFactory: BeagleMoshi = BeagleMoshi
) {

    @Throws(BeagleException::class)
    fun serializeComponent(component: ServerDrivenComponent): String {
        try {
            return beagleMoshiFactory.moshi.adapter(ServerDrivenComponent::class.java).toJson(component) ?:
            throw NullPointerException()
        } catch (ex: Exception) {
            val message = """
            Did you miss to serialize for Component ${component::class.java.simpleName}
        """.trimIndent()
           throw BeagleException("$EXCEPTION_MESSAGE$message")
        }
    }

    @Throws(BeagleException::class)
    fun deserializeComponent(json: String): ServerDrivenComponent {
        try {
            return beagleMoshiFactory.moshi.adapter(ServerDrivenComponent::class.java).fromJson(json) ?:
                throw NullPointerException()
        } catch (ex: Exception) {
            BeagleMessageLogs.logDeserializationError(json, ex)
            throw makeBeagleDeserializationException(json, ex.message)
        }
    }

    @Throws(BeagleException::class)
    fun deserializeAction(json: String): Action {
        try {
            return beagleMoshiFactory.moshi.adapter(Action::class.java).fromJson(json) ?:
                throw NullPointerException()
        } catch (ex: Exception) {
            BeagleMessageLogs.logDeserializationError(json, ex)
            throw makeBeagleDeserializationException(json, ex.message)
        }
    }

    private fun makeBeagleDeserializationException(json: String, exceptionMessage: String? = null): BeagleException {
        val message = if (exceptionMessage != null) {
            "\nWith exception message=$exceptionMessage"
        } else {
            ""
        }
        return BeagleException("$EXCEPTION_MESSAGE$json$message")
    }
}
