package br.com.zup.beagle.utils

import android.view.View
import br.com.zup.beagle.core.IdentifierComponent
import br.com.zup.beagle.core.ServerDrivenComponent

class ComponentStylization<T : ServerDrivenComponent>(
    private val accessibilitySetup: AccessibilitySetup = AccessibilitySetup()
) {
    fun apply(view: View, component: T) {
        view.applyAppearance(component)
        (component as? IdentifierComponent)?.id?.let {
            view.id = it.toAndroidId()
        }
        accessibilitySetup.applyAccessibility(view, component)
    }
}
