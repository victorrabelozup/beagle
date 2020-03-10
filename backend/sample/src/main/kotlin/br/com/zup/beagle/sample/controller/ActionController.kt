package br.com.zup.beagle.sample.controller

import br.com.zup.beagle.sample.constants.SUBMIT_FORM_ENDPOINT
import br.com.zup.beagle.sample.service.SampleFormService
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class ActionController(
    private val sampleFormService: SampleFormService
) {
    @PostMapping(SUBMIT_FORM_ENDPOINT)
    fun postSubmitForm(body: Map<String, String>)= this.sampleFormService.submitForm(body)
}