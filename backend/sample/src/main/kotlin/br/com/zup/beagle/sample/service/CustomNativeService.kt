package br.com.zup.beagle.sample.service

import br.com.zup.beagle.sample.widget.CustomNativeWidget
import org.springframework.stereotype.Service

@Service
class CustomNativeService {
    fun createCustomNativeWidget() = CustomNativeWidget()
}
