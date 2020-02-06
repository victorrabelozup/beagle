package br.com.zup.beagle.data.serializer.adapter

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.action.CustomAction
import br.com.zup.beagle.action.FormValidation
import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.data.serializer.PolymorphicJsonAdapterFactory

private const val BEAGLE_WIDGET_TYPE = "_beagleType_"
private const val BEAGLE_NAMESPACE = "beagle"
private const val ACTION_NAMESPACE = "action"

internal object ActionJsonAdapterFactory {

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