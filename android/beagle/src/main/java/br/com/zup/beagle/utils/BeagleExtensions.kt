package br.com.zup.beagle.utils

import br.com.zup.beagle.view.BeagleActivity
import br.com.zup.beagle.view.BeagleNavigator

internal fun BeagleActivity.configureSupportActionBar() {
    val toolbar = this.getToolbar()
    this.setSupportActionBar(toolbar)
    this.supportActionBar?.hide()
    toolbar.setNavigationOnClickListener {
        BeagleNavigator.pop(this)
    }
}