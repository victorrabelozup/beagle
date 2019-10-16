package br.com.zup.beagleui.framework.core

open class NativeWidget : Widget {
    override fun buildResultName(): String = "none"
    override fun build(): Widget = NativeWidget()
}