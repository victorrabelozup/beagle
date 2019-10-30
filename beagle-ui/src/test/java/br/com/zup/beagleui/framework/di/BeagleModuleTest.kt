package br.com.zup.beagleui.framework.di

import br.com.zup.beagleui.framework.data.BeagleHttpClient
import br.com.zup.beagleui.framework.data.deserializer.BeagleMoshiFactory
import br.com.zup.beagleui.framework.data.deserializer.BeagleUiDeserialization
import br.com.zup.beagleui.framework.data.repository.BeagleDataRepository
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.networking.URLFactory
import br.com.zup.beagleui.framework.networking.HttpClient
import br.com.zup.beagleui.framework.view.BeagleUIViewModel
import io.mockk.MockKAnnotations
import org.junit.Before
import org.junit.Test
import org.koin.core.context.startKoin
import org.koin.test.AutoCloseKoinTest
import org.koin.test.inject
import kotlin.test.assertNotNull

internal class BeagleModuleTest : AutoCloseKoinTest() {

    private val beagleUiViewModel by inject<BeagleUIViewModel>()
    private val beagleHttpClient by inject<BeagleHttpClient>()
    private val beagleMoshiFactory by inject<BeagleMoshiFactory>()
    private val beagleUiDeserialization by inject<BeagleUiDeserialization>()
    private val viewRendererFactory by inject<ViewRendererFactory>()
    private val beagleDataRepository by inject<BeagleDataRepository>()
    private val urlRequestDispatching by inject<HttpClient>()
    private val urlFactory by inject<URLFactory>()

    @Before
    fun before() {
        MockKAnnotations.init(this)

        startKoin {
            modules(beagleModule)
        }
    }

    @Test
    fun beagleUiViewModel_should_have_a_valid_instance() {
        assertNotNull(beagleUiViewModel)
    }

    @Test
    fun beagleHttpClient_should_have_a_valid_instance() {
        assertNotNull(beagleHttpClient)
    }

    @Test
    fun beagleMoshiFactory_should_have_a_valid_instance() {
        assertNotNull(beagleMoshiFactory)
    }

    @Test
    fun beagleUiDeserialization_should_have_a_valid_instance() {
        assertNotNull(beagleUiDeserialization)
    }

    @Test
    fun viewRendererFactory_should_have_a_valid_instance() {
        assertNotNull(viewRendererFactory)
    }

    @Test
    fun beagleDataRepository_should_have_a_valid_instance() {
        assertNotNull(beagleDataRepository)
    }

    @Test
    fun urlRequestDispatching_should_have_a_valid_instance() {
        assertNotNull(urlRequestDispatching)
    }

    @Test
    fun urlFactory_should_have_a_valid_instance() {
        assertNotNull(urlFactory)
    }
}