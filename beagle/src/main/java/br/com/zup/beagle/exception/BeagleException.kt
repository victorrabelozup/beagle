package br.com.zup.beagle.exception

import java.lang.Exception

class BeagleException
    constructor(override val message: String? = null, override val cause: Throwable? = null): Exception()
