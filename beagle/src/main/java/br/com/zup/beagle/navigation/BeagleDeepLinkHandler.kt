package br.com.zup.beagle.navigation

import android.content.Intent

interface BeagleDeepLinkHandler {
    fun getDeepLinkIntent(path: String, data: Map<String, String>?): Intent
}