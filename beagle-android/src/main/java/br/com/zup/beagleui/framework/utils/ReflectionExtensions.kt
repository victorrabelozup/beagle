package br.com.zup.beagleui.framework.utils

import java.lang.reflect.Field
import java.lang.reflect.Modifier

private const val MODIFIERS = "modifiers"
internal fun Field.setNotFinalAndAccessible() {
    try {
        this.isAccessible = true

        val modifiersField = this.javaClass.getDeclaredField(MODIFIERS)
        modifiersField.isAccessible = true
        modifiersField.setInt(this, this.modifiers and Modifier.FINAL.inv())
    } catch (e: Exception) {
        //ignored
        e.printStackTrace()
    }
}