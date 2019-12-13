package br.com.zup.beagle.utils

import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import br.com.zup.beagle.engine.renderer.ActivityRootView
import br.com.zup.beagle.engine.renderer.FragmentRootView
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.widget.core.Widget

internal var viewRenderer = ViewRendererFactory()

fun Widget.toView(activity: AppCompatActivity) = viewRenderer.make(this).build(ActivityRootView(activity))

fun Widget.toView(fragment: Fragment) = viewRenderer.make(this).build(FragmentRootView(fragment))

internal fun Widget.toView(rootView: RootView) = viewRenderer.make(this).build(rootView)
