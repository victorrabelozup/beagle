package br.com.zup.beagleui.app

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class BeagleUiSampleApplication

fun main(args: Array<String>) {
    runApplication<BeagleUiSampleApplication>(*args)
}