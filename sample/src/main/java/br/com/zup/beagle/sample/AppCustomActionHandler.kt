package br.com.zup.beagle.sample

import android.content.Context
import br.com.zup.beagle.action.CustomAction
import br.com.zup.beagle.action.CustomActionHandler

class AppCustomActionHandler : CustomActionHandler {
    override fun handle(context: Context, action: CustomAction) {
        print("Custom Action executed")
    }
}