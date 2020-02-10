package br.com.zup.beagle.navigation

import android.content.Intent

interface DeepLinkHandler {
    fun getDeepLinkIntent(path: String, data: Map<String, String>?): Intent
}