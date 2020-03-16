package br.com.zup.beagle.widget.layout

import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.AppearanceComponent
import br.com.zup.beagle.core.LayoutComponent
import br.com.zup.beagle.core.ServerDrivenComponent

internal data class ScreenComponent(
    val identifier: String? = null,
    val navigationBar: NavigationBar? = null,
    val child: ServerDrivenComponent
) : AppearanceComponent, LayoutComponent {

    override var appearance: Appearance? = null
        private set

    fun applyAppearance(appearance: Appearance): ScreenComponent {
        this.appearance = appearance
        return this
    }
}
