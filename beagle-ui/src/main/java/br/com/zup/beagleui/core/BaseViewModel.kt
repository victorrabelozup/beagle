package br.com.zup.beagleui.core

import androidx.lifecycle.ViewModel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancel

internal open class BaseViewModel : ViewModel(), CoroutineScope {

    private val job = Job()
    override val coroutineContext = job + Dispatchers.Main

    override fun onCleared() {
        super.onCleared()

        cancel()
    }
}