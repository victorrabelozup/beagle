package br.com.zup.beagleui.framework.navigation

import android.content.Intent

interface BeagleDeepLinkHandler {
    fun getDeepLinkIntent(path: String, data: Map<String, String>?): Intent
}