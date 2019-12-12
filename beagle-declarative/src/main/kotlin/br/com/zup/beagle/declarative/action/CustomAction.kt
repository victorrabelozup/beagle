package br.com.zup.beagle.declarative.action

data class CustomAction(
    val name: String,
    val data: Map<String, String>
) : Action