/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.utils

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import br.com.zup.beagle.core.Appearance
import br.com.zup.beagle.core.LayoutComponent
import br.com.zup.beagle.core.ServerDrivenComponent
import br.com.zup.beagle.engine.renderer.ActivityRootView
import br.com.zup.beagle.engine.renderer.FragmentRootView
import br.com.zup.beagle.engine.renderer.RootView
import br.com.zup.beagle.engine.renderer.ViewRendererFactory
import br.com.zup.beagle.widget.layout.Container
import br.com.zup.beagle.widget.layout.Screen
import br.com.zup.beagle.widget.layout.ScreenComponent

internal var viewRenderer = ViewRendererFactory()

fun ServerDrivenComponent.toView(context: Context) = this.toView(context as AppCompatActivity)

fun ServerDrivenComponent.toView(activity: AppCompatActivity) =
    this.toView(ActivityRootView(activity))

fun ServerDrivenComponent.toView(fragment: Fragment) = this.toView(FragmentRootView(fragment))

fun Screen.toView(activity: AppCompatActivity) = this.toComponent().toView(activity)

fun Screen.toView(fragment: Fragment) = this.toComponent().toView(fragment)

internal fun Screen.toComponent() = ScreenComponent(
    identifier = this.identifier,
    navigationBar = this.navigationBar,
    child = this.child
).applyAppearance(appearance ?: Appearance())

internal fun ServerDrivenComponent.toView(rootView: RootView) =
    if (this is LayoutComponent) {
        viewRenderer.make(this).build(rootView)
    } else {
        val container = Container(listOf(this))
        viewRenderer.make(container).build(rootView)
    }
