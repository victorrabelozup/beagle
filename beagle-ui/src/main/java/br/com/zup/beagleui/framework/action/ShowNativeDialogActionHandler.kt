package br.com.zup.beagleui.framework.action

import android.content.Context
import br.com.zup.beagleui.framework.view.ViewFactory

internal class ShowNativeDialogActionHandler(
    private val viewFactory: ViewFactory = ViewFactory()
) : ActionHandler<ShowNativeDialog> {

    override fun handle(context: Context, action: ShowNativeDialog) {
        viewFactory.makeAlertDialogBuilder(context)
            .setTitle(action.title)
            .setMessage(action.message)
            .setPositiveButton(action.buttonText) { dialog, _ ->
                dialog.dismiss()
            }.show()
    }
}
