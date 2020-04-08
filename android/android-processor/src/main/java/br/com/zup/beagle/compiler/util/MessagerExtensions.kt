/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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