package br.com.zup.beagle.action

import android.content.Context
import br.com.zup.beagle.setup.BeagleEnvironment

internal class ActionExecutor(
    private val customActionHandler: CustomActionHandler? =
        BeagleEnvironment.customActionHandler,
    private val navigationActionHandler: NavigationActionHandler =
        NavigationActionHandler(),
    private val showNativeDialogActionHandler: ShowNativeDialogActionHandler =
        ShowNativeDialogActionHandler(),
    private val formValidationActionHandler: ActionHandler<FormValidation>? = null
) {

    fun doAction(context: Context, action: Action?) {
        when (action) {
            is Navigate -> navigationActionHandler.handle(context, action)
            is ShowNativeDialog -> showNativeDialogActionHandler.handle(context, action)
            is FormValidation -> formValidationActionHandler?.handle(context, action)
            is CustomAction -> customActionHandler?.handle(context, action)
        }
    }
}
