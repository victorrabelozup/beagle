package br.com.zup.beagle.utils

fun String.toAndroidId(): Int {
    var value: Long = 0
    for (ch in this) {
        value += ch.toInt()
    }
    return value.toInt()
}