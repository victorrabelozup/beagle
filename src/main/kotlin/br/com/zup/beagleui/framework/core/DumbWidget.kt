package br.com.zup.beagleui.framework.core

open class DumbWidget : Widget() {
    override fun build(): Widget {
        return DumbWidget()
    }
}