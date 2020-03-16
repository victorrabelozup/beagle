package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.sample.service.CustomNativeService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class CustomComponentController(private val customNativeService: CustomNativeService) {
    @GetMapping
    fun getCustomNativeWidget() = customNativeService.createCustomNativeWidget()
}