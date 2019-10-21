package br.com.zup.beagleui.framework.exception

import java.lang.Exception

internal class BeagleDataException
    constructor(override val message: String? = null, override val cause: Throwable? = null): Exception()
