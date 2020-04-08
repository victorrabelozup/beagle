/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.spring.controller

import br.com.zup.beagle.sample.constants.CUSTOM_WIDGET_ENDPOINT
import br.com.zup.beagle.sample.spring.service.CustomNativeService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class CustomComponentController(private val customNativeService: CustomNativeService) {
    @GetMapping(CUSTOM_WIDGET_ENDPOINT)
    fun getCustomNativeWidget() = customNativeService.createCustomNativeWidget()
}