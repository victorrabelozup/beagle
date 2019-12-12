package br.com.zup.beagleui.framework.data.deserializer.adapter

import br.com.zup.beagleui.framework.action.Action
import br.com.zup.beagleui.framework.action.CustomAction
import br.com.zup.beagleui.framework.action.FormValidation
import br.com.zup.beagleui.framework.action.Navigate
import br.com.zup.beagleui.framework.action.ShowNativeDialog
import com.squareup.moshi.adapters.PolymorphicJsonAdapterFactory

private const val BEAGLE_WIDGET_TYPE = "_beagleType_"
private const val BEAGLE_NAMESPACE = "beagle"
private const val ACTION_NAMESPACE = "action"

class ActionJsonAdapterFactory {

    fun make(): PolymorphicJsonAdapterFactory<Action> {
        return PolymorphicJsonAdapterFactory.of(Action::class.java, BEAGLE_WIDGET_TYPE)
            .withSubtype(CustomAction::class.java, createNamespaceFor<CustomAction>())
            .withSubtype(FormValidation::class.java, createNamespaceFor<FormValidation>())
            .withSubtype(Navigate::class.java, createNamespaceFor<Navigate>())
            .withSubtype(ShowNativeDialog::class.java, createNamespaceFor<ShowNativeDialog>())
    }

    private inline fun <reified T : Action> createNamespaceFor(): String {
        return "$BEAGLE_NAMESPACE:$ACTION_NAMESPACE:${T::class.java.simpleName.toLowerCase()}"
    }
}