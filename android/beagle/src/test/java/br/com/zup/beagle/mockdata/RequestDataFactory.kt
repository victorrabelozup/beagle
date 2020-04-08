/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.mockdata

import br.com.zup.beagle.data.serializer.makeButtonJson
import br.com.zup.beagle.networking.HttpMethod
import br.com.zup.beagle.networking.RequestData
import br.com.zup.beagle.networking.ResponseData
import br.com.zup.beagle.testutil.RandomData
import java.net.URI

fun makeResponseData() = ResponseData(
    statusCode = RandomData.int(),
    data = RandomData.string().toByteArray(),
    headers = mapOf("request-type" to "application/json")
)

fun makeRequestData() = RequestData(
    uri = URI(RandomData.string()),
    method =  HttpMethod.GET,
    headers = mapOf("Authorization" to RandomData.string()),
    body = makeButtonJson()
)