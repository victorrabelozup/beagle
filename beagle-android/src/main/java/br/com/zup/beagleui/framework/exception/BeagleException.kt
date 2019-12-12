package br.com.zup.beagleui.framework.exception

import java.lang.Exception

class BeagleException
    constructor(override val message: String? = null, override val cause: Throwable? = null): Exception()
