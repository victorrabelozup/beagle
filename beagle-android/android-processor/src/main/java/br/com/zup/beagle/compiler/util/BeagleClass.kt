package br.com.zup.beagle.compiler.util

data class BeagleClass(
    val packageName: String,
    val className: String
) {
    override fun toString(): String {
        return "$packageName.$className"
    }
}