package br.com.zup.beagleui.di

import br.com.zup.beagleui.data.BeagleHttpClient
import br.com.zup.beagleui.engine.BeagleUiDeserialization
import br.com.zup.beagleui.view.BeagleUiViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.core.module.Module
import org.koin.dsl.module

val beagleModule: Module = module {
    viewModel { BeagleUiViewModel(get()) }

    factory { BeagleHttpClient(get()) }

    factory { BeagleUiDeserialization() }
}