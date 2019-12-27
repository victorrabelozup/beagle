package br.com.zup.beagle.utils

import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import br.com.zup.beagle.engine.renderer.ActivityRootView
import br.com.zup.beagle.engine.renderer.FragmentRootView
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.widget.ScreenWidget
import br.com.zup.beagle.widget.core.Widget
import br.com.zup.beagle.widget.layout.Screen

internal var viewRenderer = ViewRendererFactory()

fun Widget.toView(activity: AppCompatActivity) = this.toView(ActivityRootView(activity))

fun Widget.toView(fragment: Fragment) = this.toView(FragmentRootView(fragment))

fun Screen.toView(activity: AppCompatActivity) = this.toWidget().toView(activity)

fun Screen.toView(fragment: Fragment) = this.toWidget().toView(fragment)

internal fun Screen.toWidget() = ScreenWidget(
    navigationBar = this.navigationBar,
    header = this.header,
    content = this.content,
    footer = this.footer
)

internal fun Widget.toView(rootView: RootView) = viewRenderer.make(this).build(rootView)
