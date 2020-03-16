package br.com.zup.beagle.sample

import android.content.Context
import br.com.zup.beagle.action.CustomAction
import br.com.zup.beagle.action.CustomActionHandler
import br.com.zup.beagle.annotation.BeagleComponent

@BeagleComponent
class AppCustomActionHandler : CustomActionHandler {
    override fun handle(context: Context, action: CustomAction) {
        print("Custom Action executed")
    }
}