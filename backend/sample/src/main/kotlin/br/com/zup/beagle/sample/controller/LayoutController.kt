package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.sample.service.PageViewService
import br.com.zup.beagle.sample.service.ScrollViewService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class LayoutController(
    private val pageViewService: PageViewService,
    private val scrollViewService: ScrollViewService
) {
    @GetMapping("/pageViewSample")
    fun getPageView() = this.pageViewService.createPageView()

    @GetMapping("/scrollView")
    fun getScrollView() = this.scrollViewService.createScrollView()

}