package br.com.zup.beagleui.framework.navigation

import android.content.Intent
import br.com.zup.beagleui.framework.widget.navigation.NavigatorData

interface BeagleDeepLinkHandler {
    fun getDeepLinkIntent(data: NavigatorData): Intent
}