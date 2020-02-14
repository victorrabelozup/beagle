package br.com.zup.beagle.sample

import android.content.Intent
import br.com.zup.beagle.annotation.BeagleComponent
import br.com.zup.beagle.navigation.DeepLinkHandler

@BeagleComponent
class AppDeepLinkHandler : DeepLinkHandler {
    override fun getDeepLinkIntent(
        path: String,
        data: Map<String, String>?
    ): Intent = Intent(path)
}