package br.com.zup.beagle.utils

import android.view.View
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.widget.Widget

class ComponentStylization<T : ServerDrivenComponent>(
    private val accessibilitySetup: AccessibilitySetup = AccessibilitySetup()
) {
    fun apply(view: View, widget: T) {
        view.applyAppearance(widget)
        (widget as? Widget)?.id?.let {
            view.id = it.toAndroidId()
        }
        accessibilitySetup.applyAccessibility(view, widget)
    }
}
