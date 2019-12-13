package br.com.zup.beagle.networking

import java.net.URL

internal class URLFactory {
    fun make(url: String) = URL(url)
}