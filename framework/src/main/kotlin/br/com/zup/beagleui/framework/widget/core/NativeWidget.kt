package br.com.zup.beagleui.framework.widget.core

open class NativeWidget : Widget {
    override fun buildResultName(): String = "none"
    override fun build(): Widget = NativeWidget()
}