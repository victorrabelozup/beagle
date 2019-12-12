package br.com.zup.beagle.declarative.widget.core

import br.com.zup.beagle.declarative.widget.layout.Container

interface Screen {
    fun build() : Container
}