package br.com.zup.beagleui.app

import br.com.zup.beagleui.app.widget.CustomNativeWidget
import br.com.zup.beagleui.framework.config.BeagleInitializer
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