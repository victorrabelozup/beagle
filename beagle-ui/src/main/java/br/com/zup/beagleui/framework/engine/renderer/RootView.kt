package br.com.zup.beagleui.framework.engine.renderer

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
