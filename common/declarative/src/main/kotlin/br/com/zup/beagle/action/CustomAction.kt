package br.com.zup.beagle.action

data class CustomAction(
    val name: String,
    val data: Map<String, String>
) : Action