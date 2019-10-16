package br.com.zup.beagleui.framework.widget.core

interface Widget {
    fun buildResultName(): String
    fun build(): Widget
}