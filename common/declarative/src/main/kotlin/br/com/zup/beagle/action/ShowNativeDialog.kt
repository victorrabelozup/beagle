package br.com.zup.beagle.action

data class ShowNativeDialog(
    val title: String,
    val message: String,
    val buttonText: String
) : Action