package br.com.zup.beagleui.framework.action

import br.com.zup.beagleui.framework.widget.navigation.NavigatorData
import br.com.zup.beagleui.framework.widget.navigation.NavigatorEventType

data class Navigate(
    val type: NavigatorEventType? = null /* = NavigatorEventType.ADD_VIEW */,
    val value: NavigatorData? = null
) : Action