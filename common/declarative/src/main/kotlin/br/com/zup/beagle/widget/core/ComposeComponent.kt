package br.com.zup.beagle.widget.core

import br.com.zup.beagle.core.ServerDrivenComponent

abstract class ComposeComponent : ServerDrivenComponent {
    abstract fun build(): ServerDrivenComponent
}