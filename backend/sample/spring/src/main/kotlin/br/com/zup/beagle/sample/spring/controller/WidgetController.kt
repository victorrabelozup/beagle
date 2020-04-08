/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.spring.controller

import br.com.zup.beagle.sample.constants.PATH_LAZY_COMPONENT_ENDPOINT
import br.com.zup.beagle.sample.spring.service.SampleLazyComponentService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class WidgetController (
    private val sampleLazyComponentService: SampleLazyComponentService
){
    @GetMapping(PATH_LAZY_COMPONENT_ENDPOINT)
    fun getLazyComponent() = sampleLazyComponentService.createTextLazyComponent()
}