package br.com.zup.beagleui.framework.widget.core

interface NativeWidget : Widget {
    override fun build(): Widget = error("NativeWidgets don't need to be build!")
}