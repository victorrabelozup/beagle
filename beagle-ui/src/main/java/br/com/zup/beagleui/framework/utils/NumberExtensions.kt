package br.com.zup.beagleui.framework.utils

import br.com.zup.beagleui.framework.config.BeagleInitializer

fun Int.px(): Int = dpToPx(this.toDouble()).toInt()

fun Int.dp(): Int = pxToDp(this.toDouble()).toInt()

fun Float.px(): Float = dpToPx(this.toDouble()).toFloat()

fun Float.dp(): Float = pxToDp(this.toDouble()).toFloat()

fun Double.px(): Double = dpToPx(this)

fun Double.dp(): Double = pxToDp(this)

private fun pxToDp(value: Double): Double {
    return value / BeagleInitializer.application.resources.displayMetrics.density
}

private fun dpToPx(value: Double): Double {
    return value * BeagleInitializer.application.resources.displayMetrics.density
}
