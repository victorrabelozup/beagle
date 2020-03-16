package br.com.zup.beagle.serialization.jackson

import com.fasterxml.jackson.databind.module.SimpleModule

object BeagleModule : SimpleModule() {
    init {
        this.setSerializerModifier(BeagleSerializerModifier)
    }
}