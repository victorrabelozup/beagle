package br.com.zup.beagle.utils

import android.view.View
import br.com.zup.beagle.core.AccessibilityComponent
import br.com.zup.beagle.core.ServerDrivenComponent

class AccessibilitySetup {

    fun applyAccessibility(view: View, component: ServerDrivenComponent) {
        (component as? AccessibilityComponent)?.let { accessibilityComponent ->
            accessibilityComponent.accessibility?.accessible?.let { isAccessible ->
                view.applyImportantForAccessibility(isAccessible)
            }

            accessibilityComponent.accessibility?.accessibilityLabel?.let { accessibilityLabel ->
                view.contentDescription = accessibilityLabel
            }
        }
    }
}

internal fun View.applyImportantForAccessibility(isAccessible: Boolean) {
    this.importantForAccessibility = if (isAccessible)
        View.IMPORTANT_FOR_ACCESSIBILITY_YES
    else
        View.IMPORTANT_FOR_ACCESSIBILITY_NO
}
