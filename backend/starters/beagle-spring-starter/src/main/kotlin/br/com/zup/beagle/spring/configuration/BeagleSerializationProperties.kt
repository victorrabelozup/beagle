/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.spring.configuration

import com.fasterxml.jackson.annotation.JsonInclude
import com.fasterxml.jackson.databind.SerializationFeature
import org.springframework.boot.context.properties.ConfigurationProperties

@ConfigurationProperties(prefix = "beagle.serialization")
open class BeagleSerializationProperties(
    var include: JsonInclude.Include = JsonInclude.Include.NON_NULL,
    var features: List<SerializationFeature> = listOf(SerializationFeature.INDENT_OUTPUT)
)