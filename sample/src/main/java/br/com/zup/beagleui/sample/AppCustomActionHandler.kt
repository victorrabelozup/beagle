package br.com.zup.beagleui.sample

import android.content.Context
import br.com.zup.beagleui.framework.action.CustomAction
import br.com.zup.beagleui.framework.action.CustomActionHandler

class AppCustomActionHandler : CustomActionHandler {
    override fun handle(context: Context, action: CustomAction) {
        print("Custom Action executed")
    }
}