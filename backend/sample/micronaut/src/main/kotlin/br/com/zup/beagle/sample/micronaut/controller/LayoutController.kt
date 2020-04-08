/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.sample.micronaut.controller

import br.com.zup.beagle.sample.constants.PAGE_VIEW_ENDPOINT
import br.com.zup.beagle.sample.constants.SCROLL_VIEW_ENDPOINT
import br.com.zup.beagle.sample.micronaut.service.PageViewService
import br.com.zup.beagle.sample.micronaut.service.ScrollViewService
import io.micronaut.http.annotation.Controller
import io.micronaut.http.annotation.Get

@Controller
class LayoutController(private val pageViewService: PageViewService, private val scrollViewService: ScrollViewService) {
    @Get(PAGE_VIEW_ENDPOINT)
    fun getPageView() = this.pageViewService.createPageView()

    @Get(SCROLL_VIEW_ENDPOINT)
    fun getScrollView() = this.scrollViewService.createScrollView()

}