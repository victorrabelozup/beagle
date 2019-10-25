package br.com.zup.beagleui.framework.navigation

import android.content.Intent
import br.com.zup.beagleui.framework.widget.navigation.DeeplinkURL

interface BeagleDeepLinkHandler {
    fun getDeepLinkIntent(deepLinkURL: DeeplinkURL): Intent
}