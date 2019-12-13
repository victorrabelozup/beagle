package br.com.zup.beagle.sample

import br.com.zup.beagle.sample.widget.CustomNativeWidget
import br.com.zup.beagle.setup.BeagleInitializer
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
open class BeagleUiSampleApplication {
    init {
        BeagleInitializer.setup("sample")
                .registerWidget(CustomNativeWidget::class.java)
    }
}

fun main(args: Array<String>) {
    runApplication<BeagleUiSampleApplication>(*args)
}