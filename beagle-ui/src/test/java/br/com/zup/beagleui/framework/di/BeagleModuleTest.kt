package br.com.zup.beagleui.framework.di

import br.com.zup.beagleui.framework.data.BeagleHttpClient
import br.com.zup.beagleui.framework.data.deserializer.BeagleMoshiFactory
import br.com.zup.beagleui.framework.data.deserializer.BeagleUiDeserialization
import br.com.zup.beagleui.framework.engine.BeagleViewBuilder
import br.com.zup.beagleui.framework.engine.renderer.ViewRendererFactory
import br.com.zup.beagleui.framework.view.BeagleUiViewModel
import org.junit.Before
import org.junit.Test
import org.koin.core.context.startKoin
import org.koin.test.AutoCloseKoinTest
import org.koin.test.inject
import kotlin.test.assertEquals

internal class BeagleModuleTest : AutoCloseKoinTest() {

    private val beagleUiViewModel by inject<BeagleUiViewModel>()
    private val beagleHttpClient by inject<BeagleHttpClient>()
    private val beagleMoshiFactory by inject<BeagleMoshiFactory>()
    private val beagleUiDeserialization by inject<BeagleUiDeserialization>()
    private val viewRendererFactory by inject<ViewRendererFactory>()
    private val beagleViewBuilder by inject<BeagleViewBuilder>()

    @Before
    fun before() {
        startKoin {
            modules(beagleModule)
        }
    }

    @Test
    fun beagleUiViewModel_should_have_a_valid_instance() {
        assertEquals(Class.forName(BeagleUiViewModel::class.java.name), beagleUiViewModel.javaClass)
    }

    @Test
    fun beagleHttpClient_should_have_a_valid_instance() {
        assertEquals(Class.forName(BeagleHttpClient::class.java.name), beagleHttpClient.javaClass)
    }

    @Test
    fun beagleMoshiFactory_should_have_a_valid_instance() {
        assertEquals(Class.forName(BeagleMoshiFactory::class.java.name), beagleMoshiFactory.javaClass)
    }

    @Test
    fun beagleUiDeserialization_should_have_a_valid_instance() {
        assertEquals(Class.forName(BeagleUiDeserialization::class.java.name), beagleUiDeserialization.javaClass)
    }

    @Test
    fun viewRendererFactory_should_have_a_valid_instance() {
        assertEquals(Class.forName(ViewRendererFactory::class.java.name), viewRendererFactory.javaClass)
    }

    @Test
    fun beagleViewBuilder_should_have_a_valid_instance() {
        assertEquals(Class.forName(BeagleViewBuilder::class.java.name), beagleViewBuilder.javaClass)
    }
}