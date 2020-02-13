package br.com.zup.beagle.compiler.util

import javax.annotation.processing.Messager
import javax.lang.model.element.Element
import javax.tools.Diagnostic

internal fun Messager.error(message: String, vararg args: Any) {
    printMessage(Diagnostic.Kind.ERROR, null, message, args)
}

internal fun Messager.error(element: Element, message: String, vararg args: Any) {
    printMessage(Diagnostic.Kind.ERROR, element, message, args)
}

internal fun Messager.warning(element: Element, message: String, vararg args: Any) {
    printMessage(Diagnostic.Kind.WARNING, element, message, args)
}

internal fun Messager.warning(message: String, vararg args: Any) {
    printMessage(Diagnostic.Kind.WARNING, null, message, args)
}

private fun Messager.printMessage(kind: Diagnostic.Kind, element: Element?, message: String, vararg args: Any) {
    var msg = message
    if (args.isNotEmpty()) {
        msg = String.format(msg, args)
    }

    if (element == null) {
        this.printMessage(kind, msg)
    } else {
        this.printMessage(kind, msg, element)
    }
}