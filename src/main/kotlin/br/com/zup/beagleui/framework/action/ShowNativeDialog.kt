package br.com.zup.beagleui.framework.action

data class ShowNativeDialog(
    val title: String,
    val message: String,
    val buttonText: String
) : Action