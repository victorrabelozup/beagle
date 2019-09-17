package br.com.zup.beagleui.framework.ui

import br.com.zup.beagleui.framework.core.NativeWidget

interface ButtonAction {
    fun name(): String
    fun value(): String
}

data class NavigationAction (
    val uri: String
) : ButtonAction {
    override fun name(): String = "OPEN_VIEW"
    override fun value(): String = uri
}

data class ValidationAction (
    val ids: List<String>
) : ButtonAction {
    override fun name(): String = "VALIDATE"
    override fun value(): String = ids.toString()
}

data class Button(
    val text: String,
    val action: List<ButtonAction>? = null
) : NativeWidget()