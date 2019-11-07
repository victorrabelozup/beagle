package br.com.zup.beagleui.framework.action

data class CustomAction(
    val name: String,
    val data: Map<String, String>
) : Action