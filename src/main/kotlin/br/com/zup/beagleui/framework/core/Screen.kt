package br.com.zup.beagleui.framework.core

import br.com.zup.beagleui.framework.layout.Container

interface Screen {
    fun build() : Container
}