package br.com.zup.beagle.testutil

object RandomData {

    fun int(): Int = Math.random().toInt()

    fun double(): Double = Math.random()

    fun string(size: Int = 20): String {
        val alphabet: List<Char> = ('a'..'z') + ('A'..'Z') + ('0'..'9')
        return List(size) { alphabet.random() }.joinToString("")
    }

    fun email(): String = "${string(5)}@${string(3)}.com"

    fun httpUrl(): String = "http://${string(5)}.com/"

    fun httpsUrl(): String = "https://${string(5)}.com/"
}