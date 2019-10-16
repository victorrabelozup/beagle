package br.com.zup.beagleui.framework.core

interface Widget {
    fun buildResultName(): String
    fun build(): Widget
}