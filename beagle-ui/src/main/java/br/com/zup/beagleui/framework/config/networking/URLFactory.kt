package br.com.zup.beagleui.framework.config.networking

import java.net.URL

internal class URLFactory {
    fun make(url: String) = URL(url)
}