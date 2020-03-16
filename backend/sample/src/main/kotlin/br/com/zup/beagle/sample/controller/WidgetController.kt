package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.sample.constants.PATH_LAZY_COMPONENT_ENDPOINT
import br.com.zup.beagle.sample.service.SampleLazyComponentService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class WidgetController (
    private val sampleLazyComponentService: SampleLazyComponentService
){
    @GetMapping(PATH_LAZY_COMPONENT_ENDPOINT)
    fun getLazyComponent() = sampleLazyComponentService.createTextLazyComponent()
}