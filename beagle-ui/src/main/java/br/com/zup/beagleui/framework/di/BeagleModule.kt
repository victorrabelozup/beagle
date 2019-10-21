package br.com.zup.beagleui.framework.di

import br.com.zup.beagleui.framework.data.BeagleHttpClient
import br.com.zup.beagleui.framework.data.deserializer.BeagleMoshiFactory
import br.com.zup.beagleui.framework.data.deserializer.BeagleUiDeserialization
import br.com.zup.beagleui.framework.data.repository.BeagleDataRepository
import br.com.zup.beagleui.framework.engine.BeagleViewBuilder
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.networking.URLFactory
import br.com.zup.beagleui.framework.networking.URLRequestDispatchingFactory
import br.com.zup.beagleui.framework.view.BeagleUiViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.core.module.Module
import org.koin.dsl.module

val beagleModule: Module = module {
    viewModel { BeagleUiViewModel(get()) }

    factory { BeagleHttpClient(get(), get()) }

    single { BeagleMoshiFactory() }

    factory { BeagleUiDeserialization(get()) }

    factory { BeagleViewBuilder(get()) }

    factory { ViewRendererFactory() }

    factory { URLFactory() }

    single { URLRequestDispatchingFactory(get()).make() }

    factory { BeagleDataRepository(get()) }
}
