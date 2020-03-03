package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.annotation.BeaglePreview
import br.com.zup.beagle.sample.service.AccessibilityService
import br.com.zup.beagle.sample.service.SampleScreenBuilderService
import br.com.zup.beagle.sample.service.SampleViewService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class ScreenController(
    private val accessibilityService: AccessibilityService,
    private val sampleViewService: SampleViewService,
    private val sampleScreenBuilderService: SampleScreenBuilderService
) {
    @GetMapping("/accessibility")
    fun getAccessibilityView() = this.accessibilityService.createAccessibilityView()

    @BeaglePreview
    @GetMapping("/sample")
    fun getSampleView() = this.sampleViewService.createSampleView()

    @GetMapping("/screenbuilder")
    fun getScreenBuilder() = this.sampleScreenBuilderService.createScreenBuilder()
}