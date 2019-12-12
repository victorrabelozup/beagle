package br.com.zup.beagle.declarative.action

data class ShowNativeDialog(
    val title: String,
    val message: String,
    val buttonText: String
) : Action