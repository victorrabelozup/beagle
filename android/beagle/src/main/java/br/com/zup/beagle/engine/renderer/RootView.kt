/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package br.com.zup.beagle.engine.renderer

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.lifecycle.LifecycleOwner

internal interface RootView {
    fun getContext(): Context
    fun getLifecycleOwner(): LifecycleOwner
}

internal class FragmentRootView(
    val fragment: Fragment
) : RootView {
    override fun getContext(): Context = fragment.requireContext()

    override fun getLifecycleOwner(): LifecycleOwner = fragment.viewLifecycleOwner
}

internal class ActivityRootView(
    val activity: AppCompatActivity
) : RootView {
    override fun getContext(): Context = activity

    override fun getLifecycleOwner(): LifecycleOwner = activity
}
