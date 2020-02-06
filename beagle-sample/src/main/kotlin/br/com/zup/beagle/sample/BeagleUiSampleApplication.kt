package br.com.zup.beagle.sample

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
open class BeagleUiSampleApplication

fun main(args: Array<String>) {
    runApplication<BeagleUiSampleApplication>(*args)
}
