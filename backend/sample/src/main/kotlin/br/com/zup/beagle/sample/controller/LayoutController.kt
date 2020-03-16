package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.sample.constants.PAGE_VIEW_ENDPOINT
import br.com.zup.beagle.sample.constants.SCROLL_VIEW_ENDPOINT
import br.com.zup.beagle.sample.service.PageViewService
import br.com.zup.beagle.sample.service.ScrollViewService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class LayoutController(
    private val pageViewService: PageViewService,
    private val scrollViewService: ScrollViewService
) {
    @GetMapping(PAGE_VIEW_ENDPOINT)
    fun getPageView() = this.pageViewService.createPageView()

    @GetMapping(SCROLL_VIEW_ENDPOINT)
    fun getScrollView() = this.scrollViewService.createScrollView()

}